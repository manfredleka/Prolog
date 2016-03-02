/*
    The contents of this file are subject to the Mozilla Public License
    Version  1.1  (the "License"); you may not use this file except in
    compliance with the License. You may obtain a copy of the License at:

    http://www.mozilla.org/MPL/

    Software  distributed  under  the License is distributed on an "AS
    IS"  basis,  WITHOUT  WARRANTY  OF  ANY  KIND,  either  express or
    implied.  See  the  License  for  the  specific language governing
    rights and limitations under the License.
    The Original Code is the contents of this file.
    The  Initial  Developer  of  the  Original  Code is SICS, Swedish
    Institute of Computer Science AB (SICS).
    Portions  created  by the Initial Developer are Copyright (C) 2007
    of the Initial Developer. All Rights Reserved.
    Contributor(s):
    _____Mats Carlsson <matsc@sics.se>
    _____Nicolas Beldiceanu <Nicolas.Beldiceanu@emn.fr>

    Alternatively, if the contents of this file is included as a part of
    SICStus Prolog distribution by SICS, it may be used under the terms of
    an appropriate SICStus Prolog License Agreement (the "SICStus Prolog
    License"), in which case the provisions of the SICStus Prolog License
    are applicable instead of those above.
*/

:- multifile
    ctr_predefined/1,
    ctr_date/2,
    ctr_persons/2,
    ctr_origin/3,
    ctr_usual_name/2,
    ctr_synonyms/2,
    ctr_types/2,
    ctr_arguments/2,
    ctr_exchangeable/2,
    ctr_restrictions/2,
    ctr_typical/2,
    ctr_example/2,
    ctr_draw_example/9,
    ctr_see_also/2,
    ctr_key_words/2,
    ctr_derived_collections/2,
    ctr_graph/7,
    ctr_graph/9,
    ctr_eval/2,
    ctr_sol/3,
    ctr_logic/3.

ctr_date(diffn,['20000128','20030820','20040530','20051001','20060808']).

ctr_origin(diffn, '\\cite{BeldiceanuContejean94}', []).

ctr_types(diffn,
          ['ORTHOTOPE'-collection(ori-dvar, siz-dvar, end-dvar)]).

ctr_arguments(diffn,
              ['ORTHOTOPES'-collection(orth-'ORTHOTOPE')]).

ctr_exchangeable(diffn,
                 [items('ORTHOTOPES',all),
                  items_sync('ORTHOTOPES'^orth,all),
                  vals(['ORTHOTOPES'^orth^siz],int(>=(0)),>,dontcare,dontcare),
                  translate(['ORTHOTOPES'^orth^ori,'ORTHOTOPES'^orth^end])]).

ctr_synonyms(diffn,[disjoint ,
                    disjoint1,
                    disjoint2,
                    diff2    ]).

ctr_restrictions(diffn,
                 [size('ORTHOTOPE') > 0                        ,
                  require_at_least(2,'ORTHOTOPE',[ori,siz,end]),
                  'ORTHOTOPE'^siz >= 0                         ,
                  'ORTHOTOPE'^ori =< 'ORTHOTOPE'^end           ,
                  required('ORTHOTOPES',orth)                  ,
                  same_size('ORTHOTOPES',orth)                 ]).

ctr_typical(diffn,
            [size('ORTHOTOPE')  > 1,
             'ORTHOTOPE'^siz    > 0,
             size('ORTHOTOPES') > 1]).

ctr_graph(diffn,
          ['ORTHOTOPES'],
          1,
          ['SELF'>>collection(orthotopes)],
          [orth_link_ori_siz_end(orthotopes^orth)],
          ['NARC' = size('ORTHOTOPES')],
          []).

ctr_graph(diffn,
          ['ORTHOTOPES'],
          2,
          ['CLIQUE'(=\=)>>collection(orthotopes1,orthotopes2)],
          [two_orth_do_not_overlap(orthotopes1^orth,orthotopes2^orth)],
          ['NARC' = size('ORTHOTOPES')*size('ORTHOTOPES')-size('ORTHOTOPES')],
          []).

ctr_example(diffn,
            diffn([[orth-[[ori-2, siz-2, end-4 ], [ori-1, siz-3, end-4]] ],
                   [orth-[[ori-4, siz-4, end-8 ], [ori-3, siz-3, end-6]] ],
                   [orth-[[ori-9, siz-2, end-11], [ori-4, siz-3, end-7]] ]])).

ctr_draw_example(diffn,
                 ['ORTHOTOPES'],
                 [[[orth-[[ori-2, siz-2, end-4 ], [ori-1, siz-3, end-4]] ],
                   [orth-[[ori-4, siz-4, end-8 ], [ori-3, siz-3, end-6]] ],
                   [orth-[[ori-9, siz-2, end-11], [ori-4, siz-3, end-7]] ]]],
                 ['CLIQUE'(=\=)],
                 [1-[2,3],
                  2-[1,3],
                  3-[1,2]],
                 ['NARC'],
                 '','NARC=6',
                 []).

ctr_see_also(diffn,
 [link(specialisation,              k_alldifferent,          'when rectangles heights are all equal to %e and rectangles starts in the first dimension are all fixed', [1]),
  link(specialisation,              lex_alldifferent,        '%e replaced by %e',                              [orthotope,vector]),
  link(specialisation,              cumulatives,             '%e replaced by %e with %e %e and %e attributes', [orthotope,task,machine,assignment,origin]),
  link(specialisation,              disjunctive,             '%k replaced by %e of %e %e',                     [orthotope,task,heigth,1]),
  link(specialisation,              all_min_dist,            '%e replaced by %e, of same length',              [orthotope,'line~segment']),
  link(specialisation,              alldifferent,            '%e replaced by %e',                              [orthotope,variable]),
  link(implies,                     cumulative,              'implies one %c constraint for each dimension',   [cumulative]),
  link('implied by',                orths_are_connected,     '',                                               []),
  link('common keyword',            diffn_column,            '%k,%k',                                          ['geometrical constraint', 'orthotope']),
  link('common keyword',            diffn_include,           '%k,%k',                                          ['geometrical constraint', 'orthotope']),
  link('common keyword',            geost,                   '%k,%k',                                          ['geometrical constraint', 'non-overlapping']),
  link('common keyword',            geost_time,              '%k,%k',                                          ['geometrical constraint', 'non-overlapping']),
  link('common keyword',            non_overlap_sboxes,      '%k,%k',                                          ['geometrical constraint', 'non-overlapping']),
  link('common keyword',            calendar,                '%k',                                             ['scheduling with machine choice, calendars and preemption']),
  link('common keyword',            visible,                 '%k',                                             ['geometrical constraint']),
  link('used in graph description', orth_link_ori_siz_end,   '',                                               []),
  link('used in graph description', two_orth_do_not_overlap, '',                                               []),
  link('related',                   cumulative_two_d,        '%c is a necessary condition for %c: forget one dimension when the number of dimensions is equal to %e', [cumulative_two_d,diffn,3]),
  link('related',                   lex_chain_lesseq,        'lexicographic ordering on the origins of %e, %e, $\\ldots$', [tasks, rectangles]),
  link('related',                   lex_chain_less,          'lexicographic ordering on the origins of %e, %e, $\\ldots$', [tasks, rectangles]),
  link('related',                   two_orth_column,         '',                                                           []),
  link('related',                   two_orth_include,        '',                                                           [])]).

ctr_key_words(diffn,['core'                                                       ,
                     'decomposition'                                              ,
                     'geometrical constraint'                                     ,
                     'timetabling constraint'                                     ,
                     'orthotope'                                                  ,
                     'polygon'                                                    ,
                     'non-overlapping'                                            ,
                     'disjunction'                                                ,
                     'assignment dimension'                                       ,
                     'assignment to the same set of values'                       ,
                     'assigning and scheduling tasks that run in parallel'        ,
                     'relaxation'                                                 ,
                     'relaxation dimension'                                       ,
                     'business rules'                                             ,
                     'Klee measure problem'                                       ,
                     'sweep'                                                      ,
                     'floor planning problem'                                     ,
                     'squared squares'                                            ,
                     'packing almost squares'                                     ,
                     'Partridge'                                                  ,
                     'pentomino'                                                  ,
                     'sequence dependent set-up'                                  ,
                     'Shikaku'                                                    ,
                     'smallest square for packing consecutive dominoes'           ,
                     'smallest square for packing rectangles with distinct sizes' ,
                     'smallest rectangle area'                                    ,
                     'Conway packing problem'                                     ,
                     'strip packing'                                              ,
                     'two-dimensional orthogonal packing'                         ,
                     'pallet loading'                                             ,
                     'quadtree'                                                   ,
                     'compulsory part'                                            ,
                     'constructive disjunction'                                   ,
                     'sequencing with release times and deadlines'                ,
                     'scheduling with machine choice, calendars and preemption'   ,
                     'heuristics for two-dimensional rectangle placement problems',
                     'SAT'                                                        ]).

ctr_persons(diffn,['Beldiceanu N.'       ,
                   'Contejean E.'        ,
                   'Klee V.'             ,
                   'Nelissen J.'         ,
                   'Szymanek R.'         ,
                   'Kuchcinski K.'       ,
                   'Carlsson M.'         ,
                   'Guo Q.'              ,
                   'Thiel S.'            ,
                   'Ribeiro C.'          ,
                   'Carravilla M. A.'    ,
                   'Gambini I.'          ,
                   'Rochon du Verdier F.',
                   'Samet H.'            ,
                   'Li K.'               ,
                   'Cheng K.-H.'         ,
                   'Gehring H.'          ,
                   'Menschner K.'        ,
                   'Meyer M.'            ,
                   'Szczygiel T.'        ,
                   'Golomb S. W.'        ]).

ctr_eval(diffn, [reformulation(diffn_r)]).

diffn_r([]) :-
    !.
diffn_r(ORTHOTOPES) :-
    ORTHOTOPES = [[_-ORTH1]|_],
    length(ORTH1, K),
    collection(ORTHOTOPES, [col(K,[dvar,dvar_gteq(0),dvar])]),
    get_col_attr1(ORTHOTOPES, 1, ORIS),
    get_col_attr1(ORTHOTOPES, 2, SIZS),
    get_col_attr1(ORTHOTOPES, 3, ENDS),
    diffn1(ORIS, SIZS, ENDS).

diffn1([ORI1], [SIZ1], [END1]) :- !,
    diffn2(ORI1, SIZ1, END1).
diffn1([ORI1,ORI2|ORIS], [SIZ1,SIZ2|SIZS], [END1,END2|ENDS]) :-
    diffn2(ORI1, SIZ1, END1),
    diffn3([ORI2|ORIS], [END2|ENDS], ORI1, END1),
    diffn1([ORI2|ORIS], [SIZ2|SIZS],  [END2|ENDS]).

diffn2([], [], []).
diffn2([O|RO], [S|RS], [E|RE]) :-
    E #= O + S,
    diffn2(RO, RS, RE).    

diffn3([], [], _, _).
diffn3([ORI2|ORIS], [END2|ENDS], ORI1, END1) :-
    diffn4(ORI1, END1, ORI2, END2, Disjunction),
    call(Disjunction),
    diffn3(ORIS, ENDS, ORI1, END1).

diffn4([], [], [], [], 0).
diffn4([O1|R], [E1|S], [O2|T], [E2|U], E1 #=< O2 #\/ E2 #=< O1 #\/ V) :-
    diffn4(R, S, T, U, V).
