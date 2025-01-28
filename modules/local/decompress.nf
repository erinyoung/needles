process DECOMPRESS {
    tag "decompressing reference"
    label 'process_low'

    // using same container as other processes for simplicity
    conda "bioconda::poppunk=2.7.5"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/poppunk:2.7.0--py310h048fc13_0':
        'biocontainers/poppunk:2.7.0--py310h048fc13_0' }"

    input:
    val(file)

    output:
    path "*", emit: db
    path "versions.yml", emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    """
    # decompress it
    tar -xvjf ${file}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        db_file: ${file}
    END_VERSIONS
    """

    stub:
    """
    mkdir db

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        db_file: ${file}
    END_VERSIONS
    """
}
