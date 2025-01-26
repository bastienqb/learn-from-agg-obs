project(
  'learn-from-agg-obs',
  'cython',
  version: run_command('scripts/get_version.py', check: true).stdout().strip(),
  license: 'BSD-3',
  meson_version: '>= 1.1.0',
  default_options: [
    'c_std=c11',
  ],
)

py = import('python').find_installation(pure: false)

# Copy all the .py files to the install dir, rather than using
# py.install_sources and needing to list them explicitly one by one
install_subdir('src/aolearn', install_dir: py.get_install_dir())
