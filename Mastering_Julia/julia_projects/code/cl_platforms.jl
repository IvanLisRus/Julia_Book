#
# cl_platforms.jl
#

using OpenCL

function cl_platform(pname)
  @printf "\n%s\n\n" pf
  for pf in OpenCL.platforms()
    if contains(pf[:name],pname)
      @printf "\n%s\n\n" pf
      @printf "Название платформы:\t\t%s\n" pf[:name]
	  
      if pf[:name] == "Portable Computing Language"
        warn("PCL-платформа пока не поддерживается")
        continue
      else
        @printf "Профиль платформы\t\t:%s\n" pf[:profile]
        @printf "Поставщик платформы:\t\t%s\n" pf[:vendor]
        @printf "Версия платформы:\t\t%s\n\n" pf[:version]

        for dv in OpenCL.available_devices(pf)
          @printf "Имя устройства:\t\t%s\n" dv[:name]
          @printf "Тип устройства:\t\t%s\n" dv[:device_type]
           gms = dv[:global_mem_size] / (1024*1024)
          @printf "Память устройства:\t%i MB\n" gms
           mma = dv[:max_mem_alloc_size] / (1024*1024)
          @printf "Макс. размер выделяемой памяти устройства:\t%i MB\n" mma
           mcf = device[:max_clock_frequency]
          @printf "Макс. тактовая частота устройства:\t%i MHZ\n" mcf
           mcu = device[:max_compute_units]
          @printf "Макс. число блоков вычислений устройства:\t%i\n" mcu
           mwgs = device[:max_work_group_size]
          @printf "Макс. размер рабочей группы устройства:\t%i\n" mwgs
           mwis = device[:max_work_item_size]
          @printf "Макс. размер рабочего элемента устройства:\t%s\n" mwis
      end 
    end
  end
end
