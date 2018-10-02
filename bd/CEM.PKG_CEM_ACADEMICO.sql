CREATE OR REPLACE PACKAGE cem.pkg_cem_academico
    AS

    /******************************************************************************
    NOMBRE:       PKG_CEM_ACADEMICO
    DESCRIPCION:  Procedimientos para módulo académico del CEM Internacional
    ******************************************************************************/

    -- Registra los datos de un alumno y su matrícula en el Centro de Estudios Montreal.
    PROCEDURE sp_set_alumno_matriculado(
        p_email_usuario    IN VARCHAR2,
        p_password_usuario IN VARCHAR2,
        p_primer_nombre    IN VARCHAR2,
        p_segundo_nombre   IN VARCHAR2,
        p_apellido_paterno IN VARCHAR2,
        p_apellido_materno IN VARCHAR2,
        p_rut              IN VARCHAR2,
        p_numero_pasaporte IN VARCHAR2,
        p_sexo             IN CHAR,
        p_telefono         IN VARCHAR2,
        p_email_personal   IN VARCHAR2,
        p_fecha_nacimiento IN DATE,
        p_id_pais          IN NUMBER,
        p_respuesta        OUT VARCHAR2
    );

    -- Deja la cuenta del alumno como inactiva.
    PROCEDURE sp_del_alumno(
        p_id_alumno	IN NUMBER,
        p_respuesta	OUT VARCHAR2
    );

    -- Retorna un listado de alumnos, filtrados por los parámetros ingresados. Si no se ingresan parámetros, lista a todos los alumnos.
    PROCEDURE sp_get_list_alumnos(
        p_sexo            IN CHAR,
        p_edad            IN NUMBER,
        p_estado_alumno	  IN CHAR,
        p_respuesta	      OUT VARCHAR2,
        cur_lista_alumnos OUT SYS_REFCURSOR
    );

    -- Retorna un listado con todos los alumnos inscritos en un curso y sus notas registradas.
    PROCEDURE sp_get_list_notas_curso(
        p_id_curso	      IN NUMBER,
        p_respuesta	      OUT VARCHAR2,
        cur_lista_alumnos OUT SYS_REFCURSOR
    );

END pkg_cem_academico;


CREATE OR REPLACE PACKAGE BODY cem.pkg_cem_academico
AS

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

    PROCEDURE sp_set_alumno_matriculado(
        p_email_usuario    IN VARCHAR2,
        p_password_usuario IN VARCHAR2,
        p_primer_nombre    IN VARCHAR2,
        p_segundo_nombre   IN VARCHAR2,
        p_apellido_paterno IN VARCHAR2,
        p_apellido_materno IN VARCHAR2,
        p_rut              IN VARCHAR2,
        p_numero_pasaporte IN VARCHAR2,
        p_sexo             IN CHAR,
        p_telefono         IN VARCHAR2,
        p_email_personal   IN VARCHAR2,
        p_fecha_nacimiento IN DATE,
        p_id_pais          IN NUMBER,
        p_respuesta        OUT VARCHAR2
        )

    IS
    BEGIN

        INSERT INTO	cem.alumno(
            id_alumno,
            email_usuario,
            password_usuario,
            primer_nombre,
            segundo_nombre,
            apellido_paterno,
            apellido_materno,
            rut,
            numero_pasaporte,
            sexo,
            telefono,
            email_personal,
            fecha_nacimiento,
            id_pais
            )
        VALUES(
            seq_id_alumno.NEXTVAL,
            p_email_usuario,
            p_password_usuario,
            p_primer_nombre,
            p_segundo_nombre,
            p_apellido_paterno,
            p_apellido_materno,
            p_rut,
            p_numero_pasaporte,
            p_sexo,
            p_telefono,
            p_email_personal,
            p_fecha_nacimiento,
            p_id_pais
        );

        IF (SQL%ROWCOUNT > 0) THEN

            p_respuesta := 'OK';
            COMMIT;
        ELSE
            p_respuesta := 'No se realizó la operación';
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            p_respuesta := 'Error ' || SQLCODE || ': ' || SUBSTR(SQLERRM, 1, 200);

    END sp_set_alumno_matriculado;

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

    PROCEDURE sp_del_alumno(
        p_id_alumno	IN NUMBER,
        p_respuesta	OUT VARCHAR2
    )
    IS
    BEGIN

        UPDATE cem.alumno
        SET
            estado_cuenta = 'E'
        WHERE
            id_alumno = p_respuesta;

        -- Verificar inserción de datos
        IF (SQL%ROWCOUNT > 0) THEN

            p_respuesta := 'OK';
            COMMIT;
        ELSE
            p_respuesta := 'No se realizó la operación';
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            p_respuesta := 'Error ' || SQLCODE || ': ' || SUBSTR(SQLERRM, 1, 200);

    END sp_del_alumno;

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

    PROCEDURE sp_get_list_alumnos(
        p_sexo            IN CHAR,
        p_edad            IN NUMBER,
        p_estado_alumno	  IN CHAR,
        p_respuesta	      OUT VARCHAR2,
        cur_lista_alumnos OUT SYS_REFCURSOR
    )
    IS
    BEGIN

        OPEN cur_lista_alumnos FOR
            SELECT
                alu.id_alumno,
                alu.email_usuario,
                alu.primer_nombre,
                alu.segundo_nombre,
                alu.apellido_paterno,
                alu.apellido_materno,
                alu.estado_cuenta,
                alu.rut,
                alu.numero_pasaporte,
                alu.sexo,
                alu.telefono,
                alu.email_personal,
                alu.fecha_nacimiento,
                pais.gentilicio as nacionalidad
            FROM
                cem.alumno alu
                JOIN cem.pais pais ON alu.id_pais = pais.id_pais
            WHERE
                (p_sexo IS NULL OR p_sexo = alu.sexo) AND
                (p_estado_alumno IS NULL OR p_estado_alumno = alu.estado_cuenta);

    p_respuesta := 'OK';

    EXCEPTION
        WHEN OTHERS THEN
            p_respuesta := 'Error ' || SQLCODE || ': ' || SUBSTR(SQLERRM, 1, 200);

    END sp_get_list_alumnos;

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

    PROCEDURE sp_get_list_notas_curso(
        p_id_curso	      IN NUMBER,
        p_respuesta	      OUT VARCHAR2,
        cur_lista_alumnos OUT SYS_REFCURSOR
    )
    IS
    BEGIN

    /* * * P E N D I E N T E * * */
    p_respuesta := 'a';

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            p_respuesta := 'Error ' || SQLCODE || ': ' || SUBSTR(SQLERRM, 1, 200);

    END sp_get_list_notas_curso;

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

END pkg_cem_academico;