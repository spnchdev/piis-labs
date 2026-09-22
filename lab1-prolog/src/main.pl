:- consult('db.pl').

diagnose(PatientSymptoms, Disease, MatchingCount) :-
    disease(Disease),
    findall(Symptom, disease_symptom(Disease, Symptom), DiseaseSymptoms),
    my_intersection(PatientSymptoms, DiseaseSymptoms, Matches),
    length(Matches, MatchingCount),
    MatchingCount > 0.

my_intersection([], _, []).
my_intersection([H|T], List2, [H|Res]) :-
    member(H, List2), !,
    my_intersection(T, List2, Res).
my_intersection([_|T], List2, Res) :-
    my_intersection(T, List2, Res).

print_diagnosis(PatientSymptoms) :-
    write('Patient symptoms: '), write(PatientSymptoms), nl,
    findall(Count-Disease, diagnose(PatientSymptoms, Disease, Count), Results),
    sort(Results, SortedAscending),
    reverse(SortedAscending, SortedDescending),
    print_results(SortedDescending).

print_results([]).
print_results([Count-Disease|T]) :-
    disease_description(Disease, Desc),
    format('~w matches - ~w: ~w~n', [Count, Disease, Desc]),
    print_results(T).

test1 :-
    Symptoms = [contact_with_infected_14_days_ago, fever_37_to_40, severe_itching, rash_red_spots, fatigue],
    print_diagnosis(Symptoms).

test2 :-
    Symptoms = [fever_37_to_40, sore_throat, cough, headache],
    print_diagnosis(Symptoms).
