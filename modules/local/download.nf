process DOWNLOAD {
    tag "downloading reference for ${species}"
    label 'process_low'

    // using same container as other processes for simplicity
    conda "bioconda::poppunk=2.7.5"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/poppunk:2.7.2--py310h4d0eb5b_2':
        'biocontainers/poppunk:2.7.2--py310h4d0eb5b_2' }"

    input:
    tuple val(species), val(url)

    output:
    path("*z*"), emit: file
    path "versions.yml", emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    """
    wget --no-check-certificate $url

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        species: ${species}
        db_url: ${url}
    END_VERSIONS
    """

    stub:
    """
    mkdir db

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        species: ${species}
        db_url: ${url}
    END_VERSIONS
    """
}
