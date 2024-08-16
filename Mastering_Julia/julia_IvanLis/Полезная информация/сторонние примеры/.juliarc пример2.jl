using LispREPL
using LispSyntax
using Lazy: @>, @>>

ENV["PYTHON"] = "/usr/bin/python2"
ENV["JULIA_WARN_COLOR"] = :yellow
ENV["JULIA_INFO_COLOR"] = :cyan
ENV["LISP_PROMPT_TEXT"]  = "λ ↦ "

function sticky_shell_mode(enable::Bool = true)
    Base.active_repl.interface.modes[2].sticky = enable
end

[@eval $🔣() = run($🔡) for (🔣, 🔡) ∈ (:🐍 => `python`, :🐙 => `hy`, :λ => `clojure`, :💎 => `irb`, :💻 => `cling`, :🎮 => `nethack`)]

function setup()
    @async while true
        if isdefined(Base,:active_repl)
            # enable LipsREPL
            LispREPL.initrepl(Base.active_repl)

            # enable sticky shell mode
            sticky_shell_mode(true)

            # enable CxxREPL
            !(v"0.4" <= VERSION < v"0.5-") && @eval using Cxx

            break
        else
            sleep(0.25)
        end
    end
end

lisp"(setup)"