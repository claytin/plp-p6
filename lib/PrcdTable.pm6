use v6;

unit class PrcdTable;

method get () { return {
    'V'   => [ 'V', Nil, '(', Nil, ')', More, 'U-', More, 'not', More
             , 'B-', More, '+', More, '*', More, 'and', More , 'or', More
             , '==', More, ">", More, '^^', More ].hash,
    'U-'  => [ 'V', Less, '(', Less, ')', More, 'U-', More, 'not', More
             , 'B-', More , '+', More, '*', More, 'and', More, 'or', More
             , '==', More, ">", More, '^^', More ].hash,
    'not' => [ 'V', Less, '(', Less, ')', More, 'U-', Less, 'not', More
             , 'B-', Less , '+', Less, '*', Less, 'and', More, 'or', More
             , '==', Less, ">", Less, '^^', Less ].hash,
    'B-'  => [ 'V', Less, '(', Less, ')', More, 'U-', Less, 'not', More
             , 'B-', More , '+', More, '*', Less, 'and', More, 'or', More
             , '==', More, ">", More, '^^', More ].hash,
    '+'   => [ 'V', Less, '(', Less, ')', More, 'U-', Less, 'not', More
             , 'B-', More , '+', More, '*', Less, 'and', More, 'or', More
             , '==', More, ">", More, '^^', More ].hash,
    '*'   => [ 'V', Less, '(', Less, ')', More, 'U-', Less, 'not', More
             , 'B-', More , '+', More, '*', More, 'and', More, 'or', More
             , '==', More, ">", More, '^^', More ].hash,
    '=='  => [ 'V', Less, '(', Less, ')', More, 'U-', Less, 'not', More
             , 'B-', Less , '+', Less, '*', Less, 'and', More, 'or', More
             , '==', More, ">", More, '^^', Less ].hash,
    '>'   => [ 'V', Less, '(', Less, ')', More, 'U-', Less, 'not', More
             , 'B-', Less , '+', Less, '*', Less, 'and', More, 'or', More
             , '==', More, ">", More, '^^', Less ].hash,
    'and' => [ 'V', Less, '(', Less, ')', More, 'U-', Less, 'not', Less
             , 'B-', Less , '+', Less, '*', Less, 'and', More, 'or', More
             , '==', Less, ">", Less, '^^', Less ].hash,
    'or'  => [ 'V', Less, '(', Less, ')', More, 'U-', Less, 'not', Less
             , 'B-', Less , '+', Less, '*', Less, 'and', Less, 'or', More
             , '==', Less, ">", Less, '^^', Less ].hash,
    '^^'  => [ 'V', Less, '(', Less, ')', More, 'U-', Less, 'not', More
             , 'B-', More , '+', More, '*', Less, 'and', More, 'or', More
             , '==', More, ">", More, '^^', More ].hash,
    '('   => [ 'V', Nil, '(', Less, ')', Less, 'U-', Less, 'not', Less
             , 'B-', Less , '+', Less, '*', Less, 'and', Less, 'or', Less
             , '==', Less, ">", Less, '^^', Less ].hash,
    ')'   => [ 'V', Less, '(', More, ')', More, 'U-', More, 'not', More
             , 'B-', More , '+', More, '*', More, 'and', More, 'or', More
             , '==', More, ">", More, '^^', More ].hash,
}}
