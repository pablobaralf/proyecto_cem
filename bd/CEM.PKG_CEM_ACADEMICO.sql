CREATE OR REPLACE PACKAGE cem.pkg_cem_academico
    AS

    /******************************************************************************
    NOMBRE:       PKG_CEM_ACADEMICO
    DESCRIPCION:  Procedimientos para módulo académico del CEM Internacional

    REVISIONES:
    Ver        Fecha       Autor            Descripción
    ---------  ----------  ---------------  ------------------------------------
    0.1        14-09-2018  pbarrera         Creación
    ******************************************************************************/

    -- Registra los datos de un alumno y su matrícula en el Centro de Estudios Montreal.
    PROCEDURE sp_set_alumno_matriculado(
        p_email_usuario    IN VARCHAR2(50)
        p_password_usuario IN VARCHAR2(50)
        p_primer_nombre    IN VARCHAR2(50)
        p_segundo_nombre   IN VARCHAR2(100)
        p_apellido_paterno IN VARCHAR2(50)
        p_apellido_materno IN VARCHAR2(50)
        p_rut              IN VARCHAR2(15)
        p_numero_pasaporte IN VARCHAR2(50)
        p_sexo             IN CHAR(1)
        p_telefono         IN VARCHAR2(20)
        p_email_personal   IN VARCHAR2(50)
        p_fecha_nacimiento IN DATE
        p_id_pais          IN NUMBER
        p_respuesta        OUT VARCHAR2(250)
    );

    -- Deja la cuenta del alumno como inactiva.
    PROCEDURE sp_del_alumno(
        p_id_alumno	IN NUMBER(22)
        p_respuesta	OUT VARCHAR2
    );

    -- Retorna un listado de alumnos, filtrados por los parámetros ingresados. Si no se ingresan parámetros, lista a todos los alumnos.
    PROCEDURE sp_get_list_alumnos(
        p_id_curso	      IN NUMBER(22)
        p_id_pais_destino IN NUMBER(22)
        p_estado_alumno	  IN CHAR(1)
        p_respuesta	      OUT VARCHAR2
        cur_lista_alumnos OUT SYS_REFCURSOR
    );

    -- Retorna un listado con todos los alumnos inscritos en un curso y sus notas registradas.
    PROCEDURE sp_get_list_notas_curso (
        p_id_curso	      IN NUMBER(22)
        p_respuesta	      IN VARCHAR2
        cur_lista_alumnos OUT SYS_REFCURSOR
    );

END pkg_cem_academico;


CREATE OR REPLACE PACKAGE BODY cem.pkg_cem_academico
AS

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

    PROCEDURE sp_set_alumno_matriculado(
        p_email_usuario    IN VARCHAR2(50)
        p_password_usuario IN VARCHAR2(50)
        p_primer_nombre    IN VARCHAR2(50)
        p_segundo_nombre   IN VARCHAR2(100)
        p_apellido_paterno IN VARCHAR2(50)
        p_apellido_materno IN VARCHAR2(50)
        p_rut              IN VARCHAR2(15)
        p_numero_pasaporte IN VARCHAR2(50)
        p_sexo             IN CHAR(1)
        p_telefono         IN VARCHAR2(20)
        p_email_personal   IN VARCHAR2(50)
        p_fecha_nacimiento IN DATE
        p_id_pais          IN NUMBER
        p_respuesta        OUT VARCHAR2(250)

    AS
    
    );

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

END pkg_cem_academico;