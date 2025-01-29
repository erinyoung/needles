process ASSIGN {
    tag "assigning input fastas to db"
    label 'process_high'

    conda "bioconda::poppunk=2.7.5"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/poppunk:2.7.2--py310h4d0eb5b_2':
        'biocontainers/poppunk:2.7.2--py310h4d0eb5b_2' }"

    input:
    path qfile
    path fasta
    path db

    output:
    path "clusters", emit: db
    path "versions.yml", emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: '--run-qc'
    """
    poppunk_assign \\
        $args \\
        --db ${db} \\
        --query ${qfile} \\
        --output clusters \\
        --threads $task.cpus

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        poppunk: \$(poppunk --version | awk '{print \$2}')
        poppunk_sketch: \$(poppunk_sketch --version | awk '{print \$2}')
    END_VERSIONS
    """

    stub:
    """"
    mkdir clusters

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        poppunk: \$(poppunk --version | awk '{print \$2}')
        poppunk_sketch: \$(poppunk_sketch --version | awk '{print \$2}')
    END_VERSIONS
    """
}
