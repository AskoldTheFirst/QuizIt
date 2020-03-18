use [QuizDb];
go

/*
 * Person
 */
insert into app.Person ([Login], Email, [Password], ActivationCode) values ('FPerson', 'fp@mail.ua', 'ABC123', '111222')
declare @Person1Id int = scope_identity()

insert into app.Person ([Login], Email, [Password], ActivationCode) values ('SPerson', 'sp@mail.ua', 'ABC456', '111222')
declare @Person2Id int = scope_identity()

/*
 * Technology
 */
insert into app.Technology ([Name], [DurationInMin]) values ('C#', 30)
declare @Tech1Id int = scope_identity()

insert into app.Technology ([Name], [DurationInMin]) values ('MSSQL', 30)
declare @Tech2Id int = scope_identity()

insert into app.Technology ([Name], [DurationInMin]) values ('JavaScript', 30)
declare @Tech3Id int = scope_identity()

/*
 * Question <-> Answer
 */
insert into app.Question (TechnologyId, Content, AnswerText1, AnswerText2, AnswerText3, AnswerText4, TimeToPonderInSeconds)
values (@Tech1Id, 'What is C#', 'ORM library', 'Compiler', 'Language', 'Name of a bug', 60)
declare @Q1Id int = scope_identity()

insert into app.Answer (QuestionId, Grade1, Grade2, Grade3, Grade4) values (@Q1Id, 0, 0, 1, 0)


insert into app.Question (TechnologyId, Content, AnswerText1, AnswerText2, AnswerText3, AnswerText4, TimeToPonderInSeconds)
values (@Tech1Id, 'What is JitCompiler', 'Linker', 'Profiler', 'Transpiler', 'Run-time compiler', 60)
declare @Q2Id int = scope_identity()

insert into app.Answer (QuestionId, Grade1, Grade2, Grade3, Grade4) values (@Q2Id, 0, 0, 0, 1)


insert into app.Question (TechnologyId, Content, AnswerText1, AnswerText2, AnswerText3, AnswerText4, TimeToPonderInSeconds)
values (@Tech1Id, 'What is CLR', 'Virus', 'Common Language Runtime', 'Virtual Machine', 'Processor name', 60)
declare @Q3Id int = scope_identity()

insert into app.Answer (QuestionId, Grade1, Grade2, Grade3, Grade4) values (@Q3Id, 0, 1, 0, 0)


insert into app.Question (TechnologyId, Content, AnswerText1, AnswerText2, AnswerText3, AnswerText4, TimeToPonderInSeconds)
values (@Tech2Id, 'What is TSQL', 'Transaction', 'Language', 'Function', 'A SQL Tool', 60)
declare @Q4Id int = scope_identity()

insert into app.Answer (QuestionId, Grade1, Grade2, Grade3, Grade4) values (@Q4Id, 0, 1, 0, 0)


insert into app.Question (TechnologyId, Content, AnswerText1, AnswerText2, AnswerText3, AnswerText4, TimeToPonderInSeconds)
values (@Tech2Id, 'What is Transaction', 'Sequence of operations', 'Lightning', 'SQL query', 'Error log', 60)
declare @Q5Id int = scope_identity()

insert into app.Answer (QuestionId, Grade1, Grade2, Grade3, Grade4) values (@Q5Id, 1, 0, 0, 0)

/*
 * Quiz - ToQuestions
 */
insert into app.Quiz (PersonId, TechnologyId, CompleteDate, FinalGrade) values (@Person1Id, @Tech1Id, '2020-03-18', 67.4)
declare @Quiz1Id int = scope_identity()

insert into app.QuizToQuestion (QuizId, QuestionId) values (@Quiz1Id, @Q1Id)
insert into app.QuizToQuestion (QuizId, QuestionId) values (@Quiz1Id, @Q2Id)
insert into app.QuizToQuestion (QuizId, QuestionId) values (@Quiz1Id, @Q3Id)


insert into app.Quiz (PersonId, TechnologyId, CompleteDate, FinalGrade) values (@Person2Id, @Tech2Id, '2020-03-16', 12.7)
declare @Quiz2Id int = scope_identity()

insert into app.QuizToQuestion (QuizId, QuestionId) values (@Quiz2Id, @Q4Id)
insert into app.QuizToQuestion (QuizId, QuestionId) values (@Quiz2Id, @Q5Id)