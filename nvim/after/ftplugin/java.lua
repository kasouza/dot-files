local config = {
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.level=ALL',
        '-Xmx1G',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', '/home/kaso/Apps/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar',
        '-configuration', '/home/kaso/Apps/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux',
        '-data', vim.fn.expand('~/.cache/jdtls/workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')),
    },
    root_dir = vim.fs.root(0, { 'gradlew', '.git', 'mvnw' }),

}

require('jdtls').start_or_attach(config)
