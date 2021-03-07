export interface AtlasJson {
    ConceptSets:[ConceptSets] 
} 

export interface ConceptSets {
    id:string,
    name:string,
    expression:{
        items:[Concept] 
    } 
} 

export interface Concept {
    concept: {
        "CONCEPT_ID": string
        "CONCEPT_NAME": string,
        "STANDARD_CONCEPT": string,
        "STANDARD_CONCEPT_CAPTION": string,
        "INVALID_REASON": string,
        "INVALID_REASON_CAPTION": string,
        "CONCEPT_CODE": string,
        "DOMAIN_ID": string,
        "VOCABULARY_ID": string,
        "CONCEPT_CLASS_ID": string
    },
    "isExcluded": boolean,
    "includeDescendants": boolean,
    "includeMapped": boolean
} 