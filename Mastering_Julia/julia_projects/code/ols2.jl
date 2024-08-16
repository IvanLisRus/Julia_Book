#
# ols2.jl
#

module ols

export tols, summary

# Author: Adam Savitzky
# Email: asavitzky@forio.com
# Github: github.com/adambom

# Прортировано из Python, реализовано Vincent Nijs
# http://www.scipy.org/Cookbook/OLS?action=AttachFile&do=get&target=ols.0.2.py

# Тип Julia для множественной (многофакторной) регрессии с использованием 
# линейной аппроксимации методом МНК (Ordinary Least Squares, OLS)
# Регрессия по методу МНК на линейных уравнениях с несколькими независимыми переменными
# y = a1 * x1 + a2 * x2 + ... an * xn
# Y = AX + E

# Вход
## y = зависимая переменная
## y_varnm = строковое значение с меткой переменной для y
## x = независимые переменные, отметим, что константа добавляется по умолчанию
## x_varnm = список метко переменных для независимых переменных

# Использование
## Инициализировать новый тип ols 
### reg = ols(y, x, "y", ["x1", "x2", "x3"])
### Коэффициенты: reg.b
### R-квадрат: reg.R2
### F-статистика: reg.F
### Сводка: summary(reg)

type tols
    y::Array{Float64}
    x::Array{Float64}
    y_varnm::AbstractString 
    x_varnm::Array{AbstractString, 1}
    inv_xx::Array{Float64}
    b::Array{Float64, 1}
    nobs::Int
    ncoef::Int
    df_e::Int
    df_r::Int
    er::Array
    sse::Float64
    se::Array{Float64, 1}
    t::Array{Float64}
    #p::Array
    R2::Float64
    R2adj::Float64
    F::Float64
    #Fpv::Float64
    
    function tols(y, x, y_varnm, x_varnm)
        x = hcat(ones(size(x, 1)), x)
        xT = transpose(x)

        inv_xx = inv(xT * x)
        xy = xT * y
        b = inv_xx * xy           # вычислить коэффициенты

        nobs = size(y, 1)         # число наблюдений
        ncoef = size(x, 2)        # число коэффициентов
        df_e = nobs - ncoef       # степени свободы, ошибка 
        df_r = ncoef - 1          # степени свободы, регрессия

        er = y - x * b            # осттки
        sse = e^2/df_e            # сумма квадратов ошибок предсказания (SSE)
        se = sqrt(diag(sse * inv_xx)) # коэф. стандартные ошибки
        t = b / se                # коэф. t-статистики
        # p = (1 - cdf(abs(t), df_e)) * 2 # коэф. p-значения

        R2 = 1 - var(er) / var(y) # R-квадрат модели
        R2adj = 1 - (1 - R2) * ((nobs - 1) / (nobs - ncoef)) # скорректир. R-квадрат

        F = (R2 / df_r) / ((1 - R2) / df_e) # F-статистика модели
        # Fpv = 1 - cdf(F, df_r, df_e) # F-статистика p-значение

        new(y, x, y_varnm, x_varnm, inv_xx, b, nobs, ncoef, df_e, df_r, er, sse, se, t, R2, R2adj, F)
    end
end

function dw(self::tols)
    # Вычисляет статистику Дурбина-Ватсона 
    de = self.er - 1.
    result = dot(de, de) / dot(self.er, self.er)
    return result
end

function ll(self::tols)
    # Вычисляет логарифмическое правдоподобие и два информационных критерия модели
        
    # Model log-likelihood, AIC, and BIC criterion values 
    loglike = -(self.nobs / 2) * (1 + log(2pi)) - (self.nobs / 2) * log(dot(self.er, self.er) / self.nobs)
    aic = -2loglike / self.nobs + (2 * self.ncoef / self.nobs)
    bic = -2loglike / self.nobs + (self.ncoef * log(self.nobs)) / self.nobs

    return loglike, aic, bic
end

function summary(self::tols)
    # вывести результаты моделирования на экран

    t = time()

    # доп.статистика
    loglike, aic, bic = ll(self)
    #JB, JBpv, skew, kurtosis = self.JB()
    #omni, omnipv = self.omni()

    println("==============================================================================")
    #println("Dependent Variable: " + self.y_varnm)
    println("Method: Least Squares")
    println("Time: $t")
    println("No. obs:               $(self.nobs)")
    println("No. variables:         $(self.ncoef)")
    println("==============================================================================")
    println("variable             coefficient             std. Error              t-statistic")
    println("==============================================================================")
    for i in 1:length(self.x_varnm)
        println("$(self.x_varnm[i])         $(self.b[i])        $(self.se[i])        $(self.t[i])")
    end
    println("========================================================================================")
    println("Model Stats                                    Residual Stats")
    println("========================================================================================")
    println("R-Squared            $(self.R2)        Durbin-Watson Stat: $(dw(self))")
    println("Adjusted R-Squared   $(self.R2adj)        Omnimbus Stat:      ?")
    println("F-Statistic          $(self.F)        Prob(Omnibus stat): ?")
    println("Log-Likelihood       $loglike       Prob(JB):           ?")
    println("AIC Criterion        $aic        Skew:               ?")
    println("BIC Criterion        $bic         Kurtosis:           ?")
    println("========================================================================================")
end

function linreg{T<:Number}(X::StridedVecOrMat{T}, y::Vector{T})
    hcat(ones(T, size(X,1)), X)\y
end

end
