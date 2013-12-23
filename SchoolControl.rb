class School
    def initialize
        @control ={:Fisica=> {:Maestros=>["Juan Carlos Hernandez","Juan Perez"], :Alumnos=>[{:Alumno=>"",:Calificacion=>0.0}] },
                   :Matematicas=>{:Maestros=>["Olivia Martinez", "Juan Perez"], :Alumnos =>[{:Alumno=>"",:Calificacion=>0.0}] },
                  :BasesDeDatos=>{:Maestros=>["Olivia Martinez"], :Alumnos =>[{:Alumno=>"",:Calificacion=>0.0}] }}
    end
    def ver_materias
        @control.each_key do |llave|
        puts "los datos que ahy son #{llave}"
        end
    end
end
