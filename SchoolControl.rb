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
  end

  def ver_materias!
    puts "las materias registradas son:"
    @control.each_key do |materia|
    puts "#{materia}"
    end
  end

  def ver_maestros!
    puts "los maestros registrados son:"
    @maestros.each {|maestro| puts maestro}
  end

  def ver_alumnos!
    puts "los alumnos registrados son:"
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
      puts "#{materia} es impartida por:"
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
   respuesta = (@control[materia] != nil)?
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
      puts "las calificaciones de #{student} son:"
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
      puts "#{subject} agregado correctamente a materias"
    end
  end

  def agregar_maestro!(teacher)
    maestro = formatear!(teacher).chop
    if @maestros.include? maestro then
      puts "ya existe un profesor #{teacher}"
    else
      @maestros << maestro
      puts "#{teacher} agregado correctamente a maestros"
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

  def calificar_alumno_materia!(student,subject,score)
    asignado = false
    materia = formatear!(subject).gsub(" ","").to_sym
    alumno = formatear!(student).chop
    if existe_materia? materia and existe_alumno? alumno then
      @control[materia][:Alumnos].each do |estudiante|
        if estudiante[:Nombre] == alumno then
          asignado = true
        end
      end
      if asignado == false then
        puts "Alumno #{alumno} no esta asignado a #{materia}"
      else
        limite = @control[materia][:Alumnos].size - 1
        contador = 0
        while (contador <= limite)
          if @control[materia][:Alumnos][contador][:Nombre] == alumno
            @control[materia][:Alumnos][contador][:Calificacion] = score.to_f
          end
          contador += 1
        end
        puts "#{score} correctamente asignado a #{alumno} en #{materia}"
      end
    else
      puts "La materia #{materia} o el alumno #{student} no existe"
    end
  end

  def crear_interfaz_principal!
    puts "                        Control Escolar                         "
    puts ""
    puts ""
    puts "   que desea realizar ?   "
    puts " para realizar alguna actividad presione el primer valor escrito"
    puts " 1> por ejemplo 1 si esta fuese una opcion y despues enter"
    puts ""
    puts ""
    puts ""
    puts "0) ver Materias"
    puts "1) ver Maestros"
    puts "2) ver Alumnos"
    puts "3) ver calificaciones de alumno por materia"
    puts "4) ver todas la calificaciones de un alumno"
    puts "5) ver maestros que imparten cierta materia"
    puts "6) agregar Maestro"
    puts "7) asignar Maestro a Materia"
    puts "8) agregar Materia"
    puts "9) agregar Alumno a Materia"
    puts "a) asignar calificacion a Alumno por Materia"
    puts "s) salir de la Aplicacion"
  end

  def regresar_principal
    puts ""
    puts ""
    puts ""
    puts ""
    puts " presione la tecla r y despues enter para regresar"
    regresar = "n"
    while regresar.chomp != "r"
      regresar = gets
    end
  end

end

escuela = Escuela.new
orden = "o"
system 'clear'
escuela.crear_interfaz_principal!
while orden.chomp != "s"
  orden = gets()
  case orden.chomp
    when "0" then system 'clear'
      escuela.ver_materias!
      escuela.regresar_principal
    when "1" then system 'clear'
      escuela.ver_maestros!
      escuela.regresar_principal
    when "2" then system 'clear'
      escuela.ver_alumnos!
      escuela.regresar_principal
    when "3" then system 'clear'
      puts "Como se llama el alumno del que quiere ver su calificacion ?"
      nombre = gets
      puts "De que materia quiere ver la calificacion ?"
      materia = gets
      escuela.calificacion_por_materia nombre,materia
      escuela.regresar_principal
    when "4" then system 'clear'
      puts "como se llama el alumno del cual quiere ver sus calificaciones ?"
      nombre = gets
      escuela.calificaciones_de nombre
      escuela.regresar_principal
    when "5" then system 'clear'
      puts "de que materia quiere ver los maestros ?"
      materia = gets
      escuela.quien_imparte? materia
      escuela.regresar_principal
    when "6" then system 'clear'
      puts "como se llama el maestro que desea agregar ?"
      nombre = gets
      escuela.agregar_maestro! nombre
      escuela.regresar_principal
    when "7" then system 'clear'
      puts " como se llama el maestro que desea asignar"
      nombre = gets
      puts " que materia impatira #{nombre.chomp} ?"
      materia = gets
      escuela.asignar_profesor! nombre , materia
      escuela.regresar_principal
    when "8" then system 'clear'
      puts "que materia desea agregar ?"
      materia = gets
      escuela.agregar_materia! materia
      escuela.regresar_principal
    when "9" then system 'clear'
      puts " como se llama el alumno que desea asignar ?"
      nombre = gets
      puts " a que materia desea asignarlo ?"
      materia = gets
      escuela.asignar_alumno_materia nombre, materia
      escuela.regresar_principal
    when "a" then system 'clear'
      puts " a que alumno desea calificar"
      nombre = gets
      puts " para que materia es la calificacion"
      materia = gets
      puts " cual es la calificacion"
      nota = gets.to_f
      escuela.calificar_alumno_materia! nombre ,materia , nota
      escuela.regresar_principal
  end
  system 'clear'
  escuela.crear_interfaz_principal!
end
system 'clear'
