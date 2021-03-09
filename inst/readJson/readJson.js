"use strict";
exports.__esModule = true;
var cohortsFolder = '../cohorts/';
var fs = require('fs');
var SEP = "\t";
var HEADERS = ["conceptSetId", "conceptSetName",
    "CONCEPT_ID", "CONCEPT_NAME",
    "CONCEPT_CODE", "INVALID_REASON",
    "DOMAIN_ID", "VOCABULARY_ID",
    "CONCEPT_CLASS_ID", "includeDescendants",
    "isExcluded", "FILENAME"];
var getConceptSetInfo = function (conceptSet) {
    var lineConceptSet = "";
    lineConceptSet = lineConceptSet + conceptSet.id;
    lineConceptSet += SEP + conceptSet.name;
    return (lineConceptSet);
};
var getConceptInfo = function (concept) {
    var _concept = concept.concept;
    var line = "";
    line += _concept.CONCEPT_ID;
    line += SEP + _concept.CONCEPT_NAME;
    line += SEP + _concept.CONCEPT_CODE;
    line += SEP + _concept.INVALID_REASON;
    line += SEP + _concept.DOMAIN_ID;
    line += SEP + _concept.VOCABULARY_ID;
    line += SEP + _concept.CONCEPT_CLASS_ID;
    line += SEP + concept.includeDescendants;
    line += SEP + concept.isExcluded;
    return (line);
};
var writer = fs.createWriteStream('AtlasConceptSets.tsv', {
    flags: 'w' // 'w' means overwritting
});
// write headers:
writer.write(HEADERS.join("\t") + "\n");
fs.readdir(cohortsFolder, function (err, files) {
    files.forEach(function (file) {
        var json = require(cohortsFolder + file); // readJsonFile
        json.ConceptSets.forEach(function (conceptSet) {
            var lineBegin = getConceptSetInfo(conceptSet); // begin with ConceptSets information
            conceptSet.expression.items.forEach(function (concept) {
                var line = lineBegin + SEP + getConceptInfo(concept) + SEP + file; // add concept info and filename
                writer.write(line + "\n"); // write the line
            });
        });
    }, function () { return writer.end(); });
});
