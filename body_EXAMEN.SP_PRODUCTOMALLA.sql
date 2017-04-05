CREATE OR REPLACE PACKAGE BODY EXAMEN.SP_PRODUCTOMALLA
IS
   PROCEDURE SP_LISTA_MALLA_PRODUCTO (p_codproducto   IN     NUMBER,
                                      p_estado        IN     NUMBER,
                                      c_Listado        OUT TIPOCURSOR)
   IS
   BEGIN
      OPEN c_Listado FOR
         SELECT cp.codproducto,
                cp.descripcionlarga,
                cm.codmalla,
                cm.descripcionlarga,
                cm.estado,
                DECODE (1,
                        5, 'histórico',
                        4, 'aprobado',
                        3, 'por aprobar',
                        2, 'registrado',
                        1, 'configurado')
                   ESTADO
           FROM con_producto cp, con_malla cm
          WHERE     cp.codproducto = cm.codproducto
                AND cp.codproducto = p_codproducto
                AND cm.estado = p_estado;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
      raise_application_error(001, 'El codproducto o el estado no existen',false );
         DBMS_OUTPUT.put_line ('El producto o el estado no existen');
   END SP_LISTA_MALLA_PRODUCTO;
END SP_PRODUCTOMALLA;