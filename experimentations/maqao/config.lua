-- ================================================================================================ --
--                                         Basic parameters                                         --
-- ================================================================================================ --
-- Template of configuration file for oneview module

-- Name of the binary file to analyze
binary         = "./des"

-- List of external libraries to analyze
external_libraries = {
-- "lib.so", "lib.so"
}
-- Path to the dataset directory used by the application
-- Use an empty string or remove the declaration if no 
-- dataset is required by the application
dataset        = ""

-- Command used to run the binary. 
-- + <binary> will be replaced by the path to the binary file to run 
-- If some parameters are used, specify them in the string.
--   example: "<binary> -n4"
-- Use an empty string or remove the declaration if no 
-- specific command is required to run the application
run_command    = "<binary>"

-- Part of the command used to run the binary. 
-- It will be added at the begining of the final command. It is used to specify
-- a launcher for the application, such as mpirun for MPI applications
--   example: "mpirun -n 4"
-- Use an empty string or remove the declaration if no 
-- specific command prefix is required to run the application
mpi_command    = "cp ../../input.txt . && "

-- Dataset where the binary must be run
-- + <dataset> will be replaced by the dataset directory located into the
--   experiment directory.
-- Use an empty string or remove the declaration if no 
-- specific directory is required to run the application
run_directory  = "<dataset>"

-- Frequencies to use in some dynamic analysis
-- Use an empty table if no frequency must be used.
-- !! Need permissions to change cpufreq files !!
-- !! Do not specify frequencies if MAQAO can not modify these files !!
frequencies    = {}

-- Maximum time during which ONE-View must wait for any dynamic run to finish.
-- It can be nil (in this case, no threshold) or it can
-- be a string with the format "<nb><unit>" where 
-- <unit> is equal to 's' (seconds), 'm' (minutes), 'h' (hours)
-- and <nb> is a number of <unit>
job_submittion_threshold = "0s"

-- ================================================================================================ --
--                            Filter used to select loops to analyze                                --
-- ================================================================================================ --
-- !! Uncomment the filter you want to use !!
-- !! If no filter is specified, all innermost/single loops are used !!

-- This filter uses the first <value> loops, ordered by coverage
--filter = {
--   type = "number",
--   value = 1,
--}

-- This filter uses all loops whose coverage is greater than <value> (in percentage)
--filter = {
--   type = "coverage",
--   value = 1,
--}

-- This filter uses all loops while the cumulated coverage is lower than <value> (in percentage)
--filter = {
--   type = "cumulated_coverage",
--   value = 1,
--}

-- This filter uses all loops. In this case, the filter table can also be nil
--filter = {
--   type = "all",
--}

-- ================================================================================================ --
--                            Specify when the profiling should start                               --
-- ================================================================================================ --
-- !! Uncomment the table you want to use !!
-- !! If no table is specified, the default table has 'p' as unit and 30 as value !!
-- !! Report ONE always analyzes all loops !!

-- If the profiling should begin when the application is started
--profile_start = {
--   unit = "none",   -- Specify that no delay is needed
--   value = 0,         -- Useless value
--}

-- If the profiling should begin after a given time (in second)
--profile_start = {
--   unit = "s",      -- 's' for 'seconds'
--   value = 0,         -- delay in seconds
--}

-- If the profiling should begin after a given percentage of the application time.
-- A first run of the application is automatically performed to time the application.
--profile_start = {
--   unit = "p",      -- 'p' for 'percentage'
--   value = 0,         -- delay in percentage of the total application time
--}

-- ================================================================================================ --
--                                      Additionnal parameters                                      --
-- ================================================================================================ --
-- Table describing additionnal hardware counters analyzed.
-- Each entry is a list of hardware counters analyzed during a run.
-- Hardware counters must be separated with a comma ','.
-- Either hardware counter codes or names can be used.
-- If a set of hardware counters needs sudo permissions, set sudo_mode at true
-- !! Check that all hardware counters in a same list can be analyzed in a single run !!
--additionnal_hwc = {
--   {names="<names_1>", sudo_mode = <boolean>},
--   {names="<names_2>"},
--}

-- Exclude some areas (loops or blocks) from the experiment
--excluded_areas = {
--   {type = "loop", id = <MAQAO loop identifier>},
--}

-- DECAN analyzes several variants in a single run.
-- If decan_multi_variant is set to false, only one variant will be analyzed per run.
-- The experiment will be longer.
-- decan_multi_variant = false

-- Specify the location of the source code.
-- ONE-View looks for source code in directory specified in debug data. However when the
-- application is not compiled on the same machine than the run, source code is not located
-- in the same directory. This variable can be used to specify the source code of the application
-- in the machine used to generate the report.
-- source_code_location = ""

-- Specify maximal number of path a loop can have.
-- If a loop has more paths, it will not be analyzed by ONEVIEW. To analyze loops regardless of
-- the number of paths, the value must be 0. Default value is 4.
maximal_path_number = 4

-- Specify is sudo mode can be used during experiments.
-- Sudo mode is needed to analyze some hardware counters in report THREE or change the frequency
-- in reports TWO and THREE. 
is_sudo_available = false

