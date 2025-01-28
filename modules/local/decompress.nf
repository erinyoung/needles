process DECOMPRESS {
    tag "decompressing reference"
    label 'process_low'

    // using same container as other processes for simplicity
    conda "bioconda::poppunk=2.7.5"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/poppunk:2.7.2--py310h4d0eb5b_2':
        'biocontainers/poppunk:2.7.2--py310h4d0eb5b_2' }"

    input:
    val(file)

    output:
    path "*", emit: db

    when:
    task.ext.when == null || task.ext.when

    script:
    """
    # decompress it
    tar -xvjf ${file}
    """

    stub:
    """
    mkdir db
    """
}
