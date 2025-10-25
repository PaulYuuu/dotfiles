# Ensure directory exists, create if missing
def ensure-dir [path: path] {
    if not ($path | path exists) {
        print $"Creating directory: ($path)"
        mkdir $path
    }
}

# Initialize required directories
ensure-dir ($nu.data-dir | path join "vendor/autoload")
