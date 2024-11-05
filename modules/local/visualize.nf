process VISUALIZE {
    tag "visualize clusters for ${species}"
    label 'process_low'

    conda "bioconda::poppunk=2.7.0"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/poppunk:2.7.0--py310h048fc13_0':
        'biocontainers/poppunk:2.7.0--py310h048fc13_0' }"

    input:
    tuple val(species), path(ref)
    path query

    output:
    path "viz", emit: viz, optional: true
    path "versions.yml", emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: '--microreact'
    """
    poppunk_visualise \\
        $args \\
        --ref-db ${ref} \\
        --query-db ${query} \\
        --output viz

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        poppunk: \$(poppunk --version | awk '{print \$2}')
        poppunk_sketch: \$(poppunk_sketch --version | awk '{print \$2}')
    END_VERSIONS
    """

    stub:
    def args = task.ext.args ?: ''
    """
    mkdir viz

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        poppunk: \$(poppunk --version | awk '{print \$2}')
        poppunk_sketch: \$(poppunk_sketch --version | awk '{print \$2}')
    END_VERSIONS
    """
}
