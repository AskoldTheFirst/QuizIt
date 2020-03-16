use master;
go

if (DB_ID (N'QuizDb') is null)
	create database QuizDb;

go

use [QuizDb];
go

create table Person
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

create table Technology
(
	[Id] int identity(1, 1) not null constraint pk_technology primary key clustered,
	[Name] nvarchar(32) not null,
	[DurationInMin] smallint not null default(30)
);
go

create table Question
(
	[Id] int identity(1, 1) not null constraint pk_question primary key clustered,
	[TechnologyId] int foreign key references [Technology] ([Id]),
	[Content] nvarchar(max) not null,
	[AnswerText1] nvarchar(max) not null,
	[AnswerText2] nvarchar(max) not null,
	[AnswerText3] nvarchar(max) not null,
	[AnswerText4] nvarchar(max) not null,
	[Answer] tinyint not null, /* bit mask field */
	[TimeToPonderInSeconds] smallint not null,
	[IsRadioButton] bit default 1 not null,
	[IsActive] bit default 1 not null
);
go

create table Answer
(
	[Id] int identity(1, 1) not null constraint pk_answer primary key clustered,
	[QuestionId] int unique foreign key references [Question] ([Id]),
	[Grade1] tinyint not null default 0,
	[Grade2] tinyint not null default 0,
	[Grade3] tinyint not null default 0,
	[Grade4] tinyint not null default 0,
);
go

create table Quiz
(
	[Id] int identity(1, 1) not null constraint pk_quiz primary key clustered,
	[PersonId] int foreign key references [Person] ([Id]),
	[TechnologyId] int foreign key references [Technology] ([Id]),
	[CommenceDate] datetime2 not null default getdate(),
	[CompleteDate] datetime2 null,
	[FinalGrade] float null
);
go

create table QuizToQuestion
(
	[Id] int identity(1, 1) not null constraint pk_questionToQuiz primary key clustered,
	[QuizId] int foreign key references [Quiz] ([Id]),
	[QuestionId] int foreign key references [Question] ([Id]),
);
go