import groovy.json.JsonSlurper

def get_url(String taxid) {

    def jsonFile = new File("${workflow.projectDir}/assets/poppunk_db.json")
    def jsonData = new JsonSlurper().parse(jsonFile)

    def data = jsonData[taxid][0]

    def species = data.species
    def url = data.references

    return [species, url]
}

//
// Subworkflow with functionality specific to the erinyoung/needles pipeline
//

workflow DB_INFO {
    take:
    taxid

    main:

    Channel
        .from(taxid)
        .map { it -> get_url(it)}
        .set { ch_url }


    emit:
    download_url = ch_url

}

