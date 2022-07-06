using RiskService from './risk-service'; //앞에 만들어두었던 './risk-service'를 참조 

annotate RiskService.Risks with {	//Risks 엔티티에 어노테이션을 달고, Fiori 요소들을 레블링함. 
	title       @title: 'Title';
	prio        @title: 'Priority';
	descr       @title: 'Description';
	miti        @title: 'Mitigation';
	impact      @title: 'Impact';
}

annotate RiskService.Mitigations with {	//오브젝트를 수정 할 때 보임
	ID @(
		UI.Hidden,
		Common: {
		Text: description
		}
	);
	description  @title: 'Description';
	owner        @title: 'Owner';
	timeline     @title: 'Timeline';
	risks        @title: 'Risks';
}


annotate RiskService.Risks with @(
	UI: {
		HeaderInfo: {				//HeaderInfo: 오브젝트 페이지(오프젝트 한 개 클릭했을 때)에서 헤더 (상단부분) 정보 
			TypeName: 'Risk',
			TypeNamePlural: 'Risks',
			Title          : {		//제목과 부제목 정의 
                $Type : 'UI.DataField',
                Value : title
            },
			Description : {
				$Type: 'UI.DataField',
				Value: descr
			}
		},
		SelectionFields: [prio],	//SelectionFields: 검색할 필드
		LineItem: [					//LineItem: 목록 컬럼 설정. 보통 Value로 정의됨. 
			{Value: title},
			{Value: miti_ID},
			{
				Value: prio,
				Criticality: criticality
			},
			{
				Value: impact,
				Criticality: criticality
			}
		],

		Facets: [					//Facets: 오브젝트 페이지의 내용 정의
			{$Type: 'UI.ReferenceFacet', Label: 'Main', Target: '@UI.FieldGroup#Main'}
		],
		FieldGroup#Main: {
			Data: [
				{Value: miti_ID},
				{
					Value: prio,
					Criticality: criticality
				},
				{
					Value: impact,
					Criticality: criticality
				}
			]
		}
	},
) {

};

annotate RiskService.Risks with {
	miti @(
		Common: {
			//show text, not id for mitigation in the context of risks
			Text: miti.description  , TextArrangement: #TextOnly,
			ValueList: {
				Label: 'Mitigations',
				CollectionPath: 'Mitigations',
				Parameters: [
					{ $Type: 'Common.ValueListParameterInOut',
						LocalDataProperty: miti_ID,
						ValueListProperty: 'ID'
					},
					{ $Type: 'Common.ValueListParameterDisplayOnly',
						ValueListProperty: 'description'
					}
				]
			}
		}
	);
}
