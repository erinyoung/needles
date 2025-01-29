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
    path "db/*", emit: db
    path "versions.yml", emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    """
    mkdir db

    # decompress it
    tar -xvjf ${file} -C db

    fil=\$(ls db/*/*.h5 | cut -f 3 -d '/' | sed 's/.h5//g')

    mv db/* db/\$fil

    ls db/\$fil/\$fil.h5

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        tar: ${file}
    END_VERSIONS
    """

    stub:
    """
    mkdir -p db/db

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        tar: ${file}
    END_VERSIONS
    """
}
