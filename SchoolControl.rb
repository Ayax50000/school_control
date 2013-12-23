class Escuela
    attr_reader :control
    attr_reader :maestros
    def initialize
        @control ={:Fisica=> {:Maestros=>["Juan Carlos Hernandez","Juan Perez"], 
                              :Alumnos=>[{:Nombre=>"Juan",:Calificacion=>0.0}] },
                   :Matematicas=>{:Maestros=>["Olivia Martinez", "Juan Perez"],
                                  :Alumnos =>[{:Nombre=>"Pedro",:Calificacion=>0.0}] },
                  :BasesDeDatos=>{:Maestros=>["Olivia Martinez"],
                                  :Alumnos =>[{:Nombre=>"Juan",:Calificacion=>0.0}] }}
        @maestros = ["Juan Carlos Hernandez","Juan Perez","Olivia Martinez"]
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
            puts " la materia #{subject} no esta registrada"
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
    def existe_alumno?(estudiante)
        respuesta = false
        @control.each_key do |materia|
            @control[materia][:Alumnos].each do |alumno|
                 respuesta = true if alumno[:Nombre] == estudiante 
            end
        end 
        respuesta
    end
    def calificaciones_de(student)
        estudiante = formatear! student
        almacen_calificaciones , encontrado = [], false
        @control.each_key do |materia|
            @control[materia][:Alumnos].each do |alumno|
                if alumno[:Nombre] == estudiante.chop  then
                    almacen_calificaciones << [materia.to_s , alumno[:Calificacion].to_s]
                    encontrado = true
                end
            end
        end
        if encontrado == true then
        almacen_calificaciones.each {|resultado| puts "#{resultado[0]} = #{resultado[1]}" }
        else
            puts "el alumno #{student} no estudia en esta institucion"
        end
    end
    def calificacion_por_materia(student, subject)
        estudiante = formatear! student
        materia = formatear!(subject).gsub(" ","").to_sym
        calificacion , relacion  = 0.0 , false
        if (existe_materia? materia) and (existe_alumno? estudiante.chop) then
            @control[materia][:Alumnos].each do |alumno|
                if alumno[:Nombre] == estudiante.chop then
                    calificacion = alumno[:Calificacion]
                    relacion = true

                end
            end
            puts "#{estudiante} tiene #{calificacion} en #{subject}" if relacion == true
            puts "#{estudiante} no va a clase de #{subject}" unless relacion == true
        else
            puts "la materia #{subject} o el alumno #{student} no esta registrado"
        end
    end
    def agregar_materia!(subject)
        materia = formatear!(subject).gsub(" ","").to_sym
        if existe_materia? materia then
            puts "la materia #{subject} ya esta registrada"
        else
            @control[materia] = {:Maestros=>[""], :Alumnos=>[{:Nombre=>"",:Calificacion=>0.0}] }
        end
    end
    def agregar_maestro!(teacher)
        maestro = formatear!(teacher).chop
     if @maestros.include? maestro then
         puts "ya existe un profesor con ese nombre"
     else
         @maestros << maestro
         puts "maestro agregado correctamente"
     end
    end
    def asignar_profesor!(teacher,subject)
        materia = formatear!(subject).gsub(" ","").to_sym
        maestro = formatear!(teacher).chop
        if existe_materia? materia and @maestros.include? maestro then
           if !(@control[materia][:Maestros].include? maestro)
               @control[materia][:Maestros] << maestro
               puts "Maestro #{maestro} asignado correctamente a #{materia}"
           else
               puts "Maestro #{maestro} ya esta asignado a #{materia}"
           end
        else
               puts "La materia #{materia} o el maestro #{maestro} no existe" 
        end
    end
    def asignar_alumno_materia(student,subject)
        asignado = false
        materia = formatear!(subject).gsub(" ","").to_sym
        alumno = formatear!(student).chop
        if existe_materia? materia  then
            @control[materia][:Alumnos].each do |estudiante|
                asignado = true if estudiante[:Nombre] == alumno
            end
             if asignado == false then
                 @control[materia][:Alumnos] << {:Nombre=> alumno ,:Calificacion=>0.0}
                 puts "Alumno #{alumno} correctamente asignado a #{materia}"
             else
                 puts "Alumno #{alumno} ya esta asignado a #{materia}"
             end
        else
            puts "La materia #{materia}  no existe" 
        end
    end
end
escuela = Escuela.new
escuela.ver_materias!
escuela.ver_maestros!
escuela.ver_alumnos!
escuela.quien_imparte? "bases de datos"
escuela.calificaciones_de "juan"
escuela.calificacion_por_materia "pedro","matematicas"
escuela.existe_alumno? "pedro"
escuela.agregar_materia! "filosofia"
escuela.agregar_maestro! "Olivia martinez"
puts "#{escuela.control}"
puts "#{escuela.maestros}"
escuela.asignar_profesor! "Olivia martinez" , "filosofia"
puts "#{escuela.control}"
escuela.asignar_alumno_materia "martin serrano" , "filosofia"
puts "#{escuela.control}"
#system 'clear'
