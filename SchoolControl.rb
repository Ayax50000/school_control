class Escuela
    def initialize
        @control ={:Fisica=> {:Maestros=>["Juan Carlos Hernandez","Juan Perez"], :Alumnos=>[{:Alumno=>"",:Calificacion=>0.0}] },
                   :Matematicas=>{:Maestros=>["Olivia Martinez", "Juan Perez"], :Alumnos =>[{:Alumno=>"",:Calificacion=>0.0}] },
                  :BasesDeDatos=>{:Maestros=>["Olivia Martinez"], :Alumnos =>[{:Alumno=>"",:Calificacion=>0.0}] }}
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
end
escuela = Escuela.new
escuela.ver_materias!
escuela.ver_maestros!
