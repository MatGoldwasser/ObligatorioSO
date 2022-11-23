with Ada.Text_IO; use ADA.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Command_Line;
with Ada.Strings;
with Ada.Task_Identification; use Ada.Task_Identification;


procedure Mi_Puerto is
   Cant_de_Lugares_Atracadero : Integer := 2; 
   Cant_de_Lugares_Descarga : Integer := 2; 


   package counter is
      function get_next return integer;
    private
      data: integer := 1;
   end counter;
   package body counter is
      function get_next return integer is
         return_val: integer;
      begin
         return_val := data;
         data := data + 1;
      return return_val;
    end get_next;
  end counter;

   -- Este es el Atracadero. Solo uno por vez come.
   Task Atracadero is
      Entry EntrarAtracadero( nBarco: in integer);
      Entry SalirAtracadero( nBarco: in integer);
      Entry Ocupado(Sino : OUT integer);
   End;
   task body Atracadero is
      Atracando:Integer := 0;
      id_tarea:Task_Id := Null_Task_Id;
   begin
      id_tarea:= Current_Task;
      Put_Line ("Soy el Atracadero " & Image(id_tarea) );
      loop
         select
            when Atracando < Cant_de_Lugares => accept EntrarAtracadero( nBarco: in integer) do -- pueden entrar hasta 4
                  BarcoActual := nBarco;
                  Ada.Text_IO.Put_Line ("Barco " & BarcoActual'Image & " accede al atracadero de espera "'Image);
                  Atracando := Atracando + 1;
               End entrar;

            when Atracando < 2 => accept EntrarAtracadero;
               Atracando := Atracando + 1;
         or
            accept SalirAtracadero( nBarco: in integer);
            BarcoActual := nBarco;
            Ada.Text_IO.Put_Line ("Barco " & BarcoActual'Image & " se retira del atracadero de espera"'Image);
            Atracando := Atracando - 1;
         or
            accept Ocupado(Sino : OUT integer) do
               Sino:=Atracando;
            End Ocupado;
         or
            terminate;
         end select;
      end loop;
   end Atracadero;

   
   Task Descarga is
      Entry EmpezarADescargar( nBarco: in integer);
      Entry TerminarDeDescargar( nBarco: in integer);
      Entry Ocupado(Sino : OUT integer);
   End;
   task body Descarga is
      Descargando:Integer := 0;
      id_tarea:Task_Id := Null_Task_Id;
   begin
      id_tarea:= Current_Task;
      Put_Line ("Soy la Descarga " & Image(id_tarea) );
      loop
         select
            when Descargando < 2 => accept EmpezarADescargar( nBarco: in integer);
               BarcoActual := nBarco;
               Ada.Text_IO.Put_Line ( “Barco " & BarcoActual'Image & " accede a descargar en la grúa”'Image);
               Descargando := Descargando + 1;
         or
            accept TerminarDeDescargar( nBarco: in integer);
            BarcoActual := nBarco;
            Ada.Text_IO.Put_Line ( “Barco " & BarcoActual'Image & " se retira de la grúa”'Image);
            Descargando := Descargando - 1;
         or
            accept Ocupado(Sino : OUT integer) do
               Sino:=Descargando;
            End Ocupado;
         or
            terminate;
         end select;
      end loop;
   end Descarga;


   Task Puerto is
      Entry entrar( barco: in integer);
      Entry salir( barco: in integer);
   End;
   Task body puerto is
      en_el_puerto:Integer := 0;
      mibarco : integer;
   begin
      Ada.Text_IO.Put_Line ("Soy el puerto.");
      -- delay 1.0; -- espero a que todos estÈn listos
      loop
         select
            when en_el_puerto < Cant_de_Lugares_Atacadero + Cant_de_Lugares_Descarga => accept entrar( barco: in integer) do
                  mibarco := barco;
                  Ada.Text_IO.Put_Line ("Barco " & mibarco'Image & " accede al puerto");
                  en_el_puerto := en_el_puerto + 1;
               End entrar;
         or
            accept salir( barco: in integer);
            mibarco := barco;
            Ada.Text_IO.Put_Line ("Barco " & mibarco'Image & " se retira del puerto");
            en_el_puerto := en_el_puerto - 1;
         or
            terminate;
         end select;

      end loop;
   end puerto;


   task type Barco (numero: integer:= counter.get_next );
   task body Barco is
      id_tarea:Task_Id := Null_Task_Id;
      ocupacion: integer;
   begin
      id_tarea:= Current_Task;
      Ada.Text_IO.Put_Line ("Soy el barco " & numero'Image & "  " & Image(id_tarea) );
      Puerto.entrar( numero );
      Ada.Text_IO.Put_Line (Image(id_tarea) & " entro al puerto." );
      Atracadero.Ocupado(ocupacion);
      if ocupacion=1 then Put_Line ("Perrito " & numero'Image & " Atracadero ocupado.");
         end if;
      Atracadero.EntrAGrua;
      Put_Line ("Soy el barco " & numero'Image & " Atracando.");
      Descarga.Ocupado(ocupacion);
      if ocupacion=1 then Put_Line ("Barco " & numero'Image & " Descarga ocupado.");
         end if;
      Descarga.EmpezarADescargar;
      Atracadero.SaleDeGrua;
      Put_Line ("Soy el barco " & numero'Image & " Descargando.");
      Descarga.TerminarDeDescargar;

      Puerto.salir;
      Ada.Text_IO.Put_Line (Image(id_tarea) & " salio del puerto." );
   end Barco;

    --- array de perritos
    type ListadeBarcos is array (Integer range <>) of Barcos;

    -- Mis Perritos
    MisBarcos : ListadeBarcos(1 .. Cant_de_Barcos);


begin  --   Mi_Puerto
       --  Insert code here.
   delay 2.0; -- para esperar que todos terminen.
   null;
end Mi_Puerto;

