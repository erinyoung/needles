/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    IMPORT MODULES / SUBWORKFLOWS / FUNCTIONS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
include { DOWNLOAD               } from '../modules/local/download'
include { ASSIGN                 } from '../modules/local/assign'
include { VISUALIZE              } from '../modules/local/visualize'
include { paramsSummaryMap       } from 'plugin/nf-schema'
include { softwareVersionsToYAML } from '../subworkflows/nf-core/utils_nfcore_pipeline'
include { DB_INFO                 } from '../subworkflows/local/local'

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    RUN MAIN WORKFLOW
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

workflow NEEDLES {

    take:
    ch_fastas // channel: fastas read in from --input
    ch_query_list  // channel: samplesheet converted to query list from --input

    main:

    ch_versions = Channel.empty()

    // use taxid to get url for database download
    DB_INFO(params.taxid)

    // download a database and extract it
    DOWNLOAD (
        DB_INFO.out.download_url
    )

    // run assign
    ASSIGN (
        ch_query_list, ch_fastas.collect(), DOWNLOAD.out.db
    )
    ch_versions = ch_versions.mix(ASSIGN.out.versions)

    // create newick files
    VISUALIZE (
        DOWNLOAD.out.db,
        ASSIGN.out.db
    )
    ch_versions = ch_versions.mix(VISUALIZE.out.versions)

    //
    // Collate and save software versions
    //
    softwareVersionsToYAML(ch_versions)
        .collectFile(
            storeDir: "${params.outdir}/pipeline_info",
            name:  ''  + 'pipeline_software_' +  'mqc_'  + 'versions.yml',
            sort: true,
            newLine: true
        )
        .set { ch_collated_versions }


    summary_params = paramsSummaryMap(workflow, parameters_schema: "nextflow_schema.json")

    versions       = ch_versions                 // channel: [ path(versions.yml) ]

}

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    THE END
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
