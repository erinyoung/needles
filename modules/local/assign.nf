process ASSIGN {
    tag "assigning input fastas to ${species}"
    label 'process_medium'

    conda "bioconda::poppunk:2.7.0"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/poppunk:2.7.0--py310h048fc13_0':
        'biocontainers/poppunk:2.7.0--py310h048fc13_0' }"

    input:
    path qfile
    path fasta
    tuple val(species), path(db)

    output:
    path "clusters", emit: db
    path "versions.yml", emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    
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
    def args = task.ext.args ?: ''
    """"
    mkdir clusters

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        poppunk: \$(poppunk --version | awk '{print \$2}')
        poppunk_sketch: \$(poppunk_sketch --version | awk '{print \$2}')
    END_VERSIONS
    """
}
