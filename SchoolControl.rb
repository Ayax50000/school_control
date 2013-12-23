class Escuela
    def initialize
        @control ={:Fisica=> {:Maestros=>["Juan Carlos Hernandez","Juan Perez"], :Alumnos=>[{:Nombre=>"Juan",:Calificacion=>0.0}] },
                   :Matematicas=>{:Maestros=>["Olivia Martinez", "Juan Perez"], :Alumnos =>[{:Nombre=>"Pedro",:Calificacion=>0.0}] },
                  :BasesDeDatos=>{:Maestros=>["Olivia Martinez"], :Alumnos =>[{:Nombre=>"Juan",:Calificacion=>0.0}] }}
        nil
    end
    def ver_materias!
        @control.each_key do |materia|
        puts "#{materia}"
        end
        nil
    end
    def ver_maestros!
        almacen_maestros = []
        @control.each_key do |materia|
            @control[materia][:Maestros].each do |maestro|
                almacen_maestros << maestro unless almacen_maestros.include? maestro
            end
        end 
        almacen_maestros.each {|maestro| puts maestro}
    end
    def ver_alumnos!
        almacen_alumnos = []
        @control.each_key do |materia|
            @control[materia][:Alumnos].each do |alumno|
                almacen_alumnos << alumno[:Nombre] unless almacen_alumnos.include? alumno[:Nombre] 
            end
        end 
        almacen_alumnos.each {|alumno| puts alumno }
    end
    def quien_imparte?(subject)
        materia = formatear! subject
        materia = materia.gsub(" ","")
        materia = materia.to_sym
        if existe_materia? materia then
        @control[materia][:Maestros].each { |maestro| puts maestro }
        else
            puts " la materia #{subject} no existe"
        end
    end
    def formatear!(expresion)
        capitalizado = ""
        frase = expresion.split
        frase.each { |palabra| capitalizado << palabra.capitalize + " "}
        capitalizado 
    end
    def existe_materia?(materia)
        respuesta = false
        respuesta = true if @control[materia] != nil
        respuesta
    end
end
escuela = Escuela.new
#escuela.ver_materias!
#escuela.ver_maestros!
#escuela.ver_alumnos!
escuela.quien_imparte? "bases de dato"
