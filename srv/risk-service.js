//CAP는 같은 파일명을 찾아서 이어줌.(risk-service.js, risk-service.cds)
//impact의 값에 따라 프로퍼티의 criticality의 값을 바꿈. (OData 어노테이션)

const cds = require('@sap/cds')

/**
 * Implementation for Risk Management service defined in ./risk-service.cds
 */
module.exports = cds.service.impl(async function() {
    this.after('READ', 'Risks', risksData => {  
        //after: 파라미터의 'READ' 이벤트가 끝난 다음 실행됨. (모든 Risk들을 가져온 다음 실행.)
        const risks = Array.isArray(risksData) ? risksData : [risksData];
        risks.forEach(risk => {
            if (risk.impact >= 100000) {
                risk.criticality = 1;
            } else {
                risk.criticality = 2;
            }
        });
    });
});