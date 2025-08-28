GO 

USE master

GO

DROP DATABASE IF EXISTS GUIA5_1_Ejercicio1_DB_manuco

GO

CREATE DATABASE GUIA5_1_Ejercicio1_DB_manuco

GO

USE GUIA5_1_Ejercicio1_DB_manuco

GO

CREATE TABLE Figuras
(
	Id INT IDENTITY,
	Area DECIMAL(18, 2) DEFAULT (0),
	Tipo INT NOT NULL,
	Ancho DECIMAL(18, 2),
	Largo DECIMAL(18, 2),
	Radio DECIMAL(18, 2),
	CONSTRAINT PK_Figuras PRIMARY KEY (Id)
);

GO

INSERT INTO Figuras (Tipo, Ancho, Largo, Radio)
VALUES
(1, 5, 5, NULL),
(1, 5, 5, NULL),
(2, NULL, NULL, 2.5),
(2, NULL, NULL, 1.5);

SELECT f.Id,
Tipo = CASE WHEN f.Tipo = 1 THEN 'Rectangulo'
	 WHEN f.Tipo = 2 THEN 'Circulo'
	 ELSE 'Desconocido'
	 END,
f.Area,
f.Ancho,
f.Largo,
f.Radio
FROM Figuras f
ORDER BY f.Tipo ASC

GO
	
	CREATE PROCEDURE Sp_Calcular_Area
	(
		@Id INT
	) 
	AS
	BEGIN
		--UPDATE Figuras SET Area=Ancho*Largo
		--WHERE Id=@Id AND Tipo=1;

		--UPDATE Figuras SET Area=3.1415*Radio*Radio
		--WHERE Id=@Id AND Tipo=2;

		UPDATE Figuras SET Area= CASE WHEN Tipo=1 THEN Ancho*Largo
									  WHEN Tipo=2 THEN 3.1415*Radio*Radio
									  ELSE 0 END
		WHERE Id=@Id;
	END

GO

--EXEC Sp_Calcular_Area @Id= 1;
--EXEC Sp_Calcular_Area @Id= 2;
--EXEC Sp_Calcular_Area @Id= 3;
--EXEC Sp_Calcular_Area @Id= 4;

--SELECT * FROM Figuras; 

GO

DECLARE Figura_CURSOR CURSOR FOR SELECT f.Id FROM Figuras f;

OPEN Figura_CURSOR;

DECLARE @Id_ INT 

FETCH NEXT FROM Figura_CURSOR INTO @Id_;

WHILE @@FETCH_STATUS=0
BEGIN
	EXEC Sp_Calcular_Area @Id=@Id_

	FETCH NEXT FROM Figura_CURSOR INTO @Id_;
END

CLOSE Figura_CURSOR;

DEALLOCATE Figura_CURSOR;

GO

SELECT * FROM Figuras;

GO

USE master