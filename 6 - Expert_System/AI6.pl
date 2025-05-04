% Employee Performance Evaluation Expert System

% Knowledge Base - Rules for performance evaluation

% User Interface
start :-
    write('Employee Performance Evaluation System'), nl,
    write('Please answer the following questions with yes or no:'), nl, nl,
    evaluate_performance(Result, Recommendations),
    nl, write('Performance Evaluation Result: '), write(Result), nl, nl,
    write('Recommendations:'), nl,
    display_recommendations(Recommendations).

% Main evaluation predicate
evaluate_performance(Result, Recommendations) :-
    % Gather data about the employee
    ask('Does the employee meet project deadlines?', MeetsDeadlines),
    ask('Does the employee produce high quality work?', QualityWork),
    ask('Does the employee show initiative?', ShowsInitiative),
    ask('Does the employee work well in a team?', Teamwork),
    ask('Does the employee have good communication skills?', Communication),
    ask('Has the employee missed work frequently?', FrequentAbsences),
    ask('Has the employee received customer complaints?', CustomerComplaints),
    
    % Evaluate performance based on gathered data
    determine_performance(MeetsDeadlines, QualityWork, ShowsInitiative, 
                         Teamwork, Communication, FrequentAbsences, 
                         CustomerComplaints, Result),
    
    % Generate recommendations
    generate_recommendations(MeetsDeadlines, QualityWork, ShowsInitiative, 
                            Teamwork, Communication, FrequentAbsences, 
                            CustomerComplaints, Recommendations).

% Performance determination rules
determine_performance(yes, yes, yes, yes, yes, no, no, 'Outstanding').
determine_performance(yes, yes, yes, yes, yes, no, yes, 'Excellent').
determine_performance(yes, yes, no, yes, yes, no, no, 'Very Good').
determine_performance(yes, yes, no, no, yes, no, no, 'Good').
determine_performance(yes, no, no, no, no, no, no, 'Satisfactory').
determine_performance(no, no, no, no, no, no, no, 'Needs Improvement').
determine_performance(_, _, _, _, _, yes, _, 'Needs Improvement - Attendance Issues').
determine_performance(_, _, _, _, _, _, yes, 'Needs Improvement - Customer Relations').
determine_performance(_, _, _, _, _, yes, yes, 'Poor - Immediate Action Required').

% Recommendation generation rules
generate_recommendations(MeetsDeadlines, QualityWork, ShowsInitiative, 
                         Teamwork, Communication, FrequentAbsences, 
                         CustomerComplaints, Recommendations) :-
    findall(R, (
        (MeetsDeadlines == no, R = 'Time management training'),
        (QualityWork == no, R = 'Quality assurance training'),
        (ShowsInitiative == no, R = 'Assign more challenging tasks'),
        (Teamwork == no, R = 'Team building exercises'),
        (Communication == no, R = 'Communication skills workshop'),
        (FrequentAbsences == yes, R = 'Attendance counseling'),
        (CustomerComplaints == yes, R = 'Customer service training')
    ), Recommendations).

% Helper to display recommendations
display_recommendations([]) :-
    write('  No specific recommendations - keep up the good work!').
display_recommendations([H|T]) :-
    write('  - '), write(H), nl,
    display_recommendations(T).

% Ask predicate to get user input
ask(Question, Answer) :-
    write(Question), write(' (yes/no): '),
    read(Answer),
    (Answer == yes ; Answer == no), !.
ask(Question, Answer) :-
    write('Please answer with either yes or no.'), nl,
    ask(Question, Answer).