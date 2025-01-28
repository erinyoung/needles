process VISUALIZE {
    tag "visualize clusters"
    label 'process_low'

    conda "bioconda::poppunk=2.7.5"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/poppunk:2.7.2--py310h4d0eb5b_2':
        'biocontainers/poppunk:2.7.2--py310h4d0eb5b_2' }"

    input:
    path ref
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
    """
    mkdir viz

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        poppunk: \$(poppunk --version | awk '{print \$2}')
        poppunk_sketch: \$(poppunk_sketch --version | awk '{print \$2}')
    END_VERSIONS
    """
}
