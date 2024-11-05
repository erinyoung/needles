process DOWNLOAD {
    tag "downloading reference for ${species}"
    label 'process_medium'

    // using same container as other processes for simplicity
    conda "bioconda::poppunk:2.7.0"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/poppunk:2.7.0--py310h048fc13_0':
        'biocontainers/poppunk:2.7.0--py310h048fc13_0' }"

    input:
    tuple val(species), val(url)

    output:
    tuple val(species), path("*"), emit: db
    //just downloading a file, no version to report
    //path "versions.yml", emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    """
    # download database with url
    wget $url

    # decompress it
    tar -xvjf *bz2

    # remove it
    rm -rf *bz2

    db=\$(ls -d * )
    """

    stub:
    """
    mkdir db
    """
}
