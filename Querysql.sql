-- ==============================================
-- DATABASE: VocabularyJournalDB
-- DESCRIPTION: Registro diario de tareas de vocabulario
-- AUTHOR: Kevin Hernández (kehernandez)
-- DATE: 2025-11-03
-- ==============================================

-- 1️⃣ Crear la base de datos
CREATE DATABASE VocabularyJournalDB;
GO

USE VocabularyJournalDB;
GO

-- ==============================================
-- 2️⃣ Tabla: Users
-- ==============================================
CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(MAX) NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSDATETIME()
);
GO

-- ==============================================
-- 3️⃣ Tabla: DailyTasks
-- ==============================================
CREATE TABLE DailyTasks (
    TaskId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    [Date] DATE NOT NULL,
    [Source] NVARCHAR(200) NULL,
    Goal1 NVARCHAR(MAX) NULL,
    Goal2 NVARCHAR(MAX) NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSDATETIME(),

    CONSTRAINT FK_DailyTasks_Users FOREIGN KEY (UserId)
        REFERENCES Users(UserId)
        ON DELETE CASCADE
);
GO

-- Índice para búsquedas rápidas por usuario y fecha
CREATE INDEX IX_DailyTasks_User_Date ON DailyTasks (UserId, [Date]);
GO

-- ==============================================
-- 4️⃣ Tabla: WordEntries
-- ==============================================
CREATE TABLE WordEntries (
    WordId INT IDENTITY(1,1) PRIMARY KEY,
    TaskId INT NOT NULL,
    [Word] NVARCHAR(100) NOT NULL,
    Meaning NVARCHAR(200) NULL,
    OriginalPhrase NVARCHAR(MAX) NULL,
    UserExample NVARCHAR(MAX) NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSDATETIME(),

    CONSTRAINT FK_WordEntries_DailyTasks FOREIGN KEY (TaskId)
        REFERENCES DailyTasks(TaskId)
        ON DELETE CASCADE
);
GO

-- Índice para búsqueda rápida por palabra
CREATE INDEX IX_WordEntries_Word ON WordEntries ([Word]);
GO

-- ==============================================
-- 5️⃣ Vistas útiles
-- ==============================================

-- Vista: Últimas tareas del usuario
CREATE VIEW vw_UserRecentTasks AS
SELECT 
    u.FullName,
    d.TaskId,
    d.[Date],
    d.[Source],
    d.Goal1,
    d.Goal2,
    COUNT(w.WordId) AS WordCount
FROM Users u
INNER JOIN DailyTasks d ON u.UserId = d.UserId
LEFT JOIN WordEntries w ON d.TaskId = w.TaskId
GROUP BY u.FullName, d.TaskId, d.[Date], d.[Source], d.Goal1, d.Goal2;
GO

-- Vista: Detalle de palabras por tarea
CREATE VIEW vw_TaskWordDetails AS
SELECT 
    d.TaskId,
    d.[Date],
    d.[Source],
    w.WordId,
    w.[Word],
    w.Meaning,
    w.OriginalPhrase,
    w.UserExample
FROM DailyTasks d
INNER JOIN WordEntries w ON d.TaskId = w.TaskId;
GO

-- ==============================================
-- 6️⃣ Datos iniciales de ejemplo (opcional)
-- ==============================================
INSERT INTO Users (FullName, Email, PasswordHash)
VALUES ('Kevin Hernández', 'kevin@example.com', 'HASH_PLACEHOLDER');

INSERT INTO DailyTasks (UserId, [Date], [Source], Goal1, Goal2)
VALUES (1, '2025-10-30', 'PB3 and Coco the Clown',
        'Franklin Velasquez will be a Data Scientist in a tech company by August 1st, 2026.',
        'Use 10 of the new words in 10 original sentences in my notebook today.');

INSERT INTO WordEntries (TaskId, [Word], Meaning, OriginalPhrase, UserExample)
VALUES
(1, 'Acrobat', 'Acróbata', 'Katya is an acrobat and the circus schoolteacher.', 'The acrobat was able to balance on one hand.'),
(1, 'Spaceship', 'Nave espacial', 'OH! It’s a spaceship!', 'My little brother wants to pilot a spaceship to the Moon.'),
(1, 'Trousers', 'Pantalones', 'He wears big yellow trousers.', 'I need to buy new black trousers for the school uniform.');
GO
