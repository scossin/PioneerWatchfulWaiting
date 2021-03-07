import { AtlasJson, Concept, ConceptSets} from "./AtlasJson"; 

const cohortsFolder = '../cohorts/';
const fs = require('fs');
const SEP = "\t";
const HEADERS = ["conceptSetId","conceptSetName",
                "CONCEPT_ID","CONCEPT_NAME",
                "CONCEPT_CODE","INVALID_REASON",
                "DOMAIN_ID","VOCABULARY_ID",
                "CONCEPT_CLASS_ID","includeDescendants",
                "FILENAME"] 

let getConceptSetInfo:(conceptSet:ConceptSets) => string =(conceptSet:ConceptSets) => {
    var lineConceptSet = "";
    lineConceptSet = lineConceptSet + conceptSet.id;
    lineConceptSet += SEP + conceptSet.name
    return(lineConceptSet);
} 

let getConceptInfo:(concept:Concept) => string = (concept:Concept) => {
    let _concept = concept.concept;
    let line = "";
    line += _concept.CONCEPT_ID;
    line += SEP + _concept.CONCEPT_NAME;
    line += SEP + _concept.CONCEPT_CODE;
    line += SEP + _concept.INVALID_REASON;
    line += SEP + _concept.DOMAIN_ID;
    line += SEP + _concept.VOCABULARY_ID;
    line += SEP + _concept.CONCEPT_CLASS_ID;
    line += SEP + concept.includeDescendants;
    return(line);
}

var writer = fs.createWriteStream('AtlasConceptSets.tsv', {
  flags: 'w' // 'w' means overwritting
});

// write headers:
writer.write(HEADERS.join("\t") + "\n")

fs.readdir(cohortsFolder, (err:Error, files:[string]) => {
  files.forEach(file => { // for each file
    let json:AtlasJson = require(cohortsFolder + file); // readJsonFile
    json.ConceptSets.forEach((conceptSet:ConceptSets) => { // for each ConceptSet of the JsonFile
        var lineBegin = getConceptSetInfo(conceptSet);  // begin with ConceptSets information
        conceptSet.expression.items.forEach((concept:Concept) => { // for each concept of conceptSet
            var line = lineBegin + SEP + getConceptInfo(concept) + SEP + file; // add concept info and filename
            writer.write(line + "\n"); // write the line
        });
  });
}, () => writer.end());
});
