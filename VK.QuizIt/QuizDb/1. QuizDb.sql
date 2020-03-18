use master;
go

if (DB_ID (N'QuizDb') is null)
	create database QuizDb;

go

use [QuizDb];
go

create schema app;
go

create table app.Person
(
	[Id] int identity(1, 1) not null constraint pk_person primary key nonclustered,
	[Login] nvarchar(50) not null unique clustered,
	[Email] nvarchar(254) not null,
	[Password] nvarchar(16) not null,
	[ActivationCode] nchar(6) not null,
	[RegistrationDate] datetime2 default getdate() not null,
	[ActivationDate] datetime2 null
);
go

create table app.Technology
(
	[Id] int identity(1, 1) not null constraint pk_technology primary key clustered,
	[Name] nvarchar(32) not null,
	[DurationInMin] smallint not null default(30)
);
go

create table app.Question
(
	[Id] int identity(1, 1) not null constraint pk_question primary key clustered,
	[TechnologyId] int foreign key references app.[Technology] ([Id]),
	[Content] nvarchar(max) not null,
	[AnswerText1] nvarchar(max) not null,
	[AnswerText2] nvarchar(max) not null,
	[AnswerText3] nvarchar(max) not null,
	[AnswerText4] nvarchar(max) not null,
	[TimeToPonderInSeconds] smallint not null,
	[IsRadioButton] bit default 1 not null,
	[IsActive] bit default 1 not null
);
go

create table app.Answer
(
	[Id] int identity(1, 1) not null constraint pk_answer primary key clustered,
	[QuestionId] int unique foreign key references app.[Question] ([Id]),
	[Grade1] tinyint not null default 0,
	[Grade2] tinyint not null default 0,
	[Grade3] tinyint not null default 0,
	[Grade4] tinyint not null default 0,
);
go

create table app.Quiz
(
	[Id] int identity(1, 1) not null constraint pk_quiz primary key clustered,
	[PersonId] int foreign key references app.[Person] ([Id]),
	[TechnologyId] int foreign key references app.[Technology] ([Id]),
	[CommenceDate] datetime2 not null default getdate(),
	[CompleteDate] datetime2 null,
	[FinalGrade] float null
);
go

create table app.QuizToQuestion
(
	[Id] int identity(1, 1) not null constraint pk_questionToQuiz primary key clustered,
	[QuizId] int foreign key references app.[Quiz] ([Id]),
	[QuestionId] int foreign key references app.[Question] ([Id]),
);
go