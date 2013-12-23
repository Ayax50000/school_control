class School
    def initialize
        @control={:Fisica=>{:Maestros=>["Juan Carlos Hernandez","Juan Perez"],
                            :Alumnos =>[{:Alumno=>"",:Calificacion= 0.0}] },
                  :Matematicas=>{:Maestros=>["Olivia Martinez", "Juan Perez"],
                            :Alumnos =>[{:Alumno=>"",:Calificacion= 0.0}] },
                  :BasesDeDatos=>{:Maestros=>["Olivia Martinez"],
                            :Alumnos =>[{:Alumno=>"",:Calificacion= 0.0}] },}
    end
    def mostrar
        puts "los datos que ahy son #{@control}"
    end
end
