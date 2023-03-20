set_xmakever("2.7.2")
set_project("rnnoise")

set_arch("x64")
set_languages("c11")
set_runtimes(is_mode("debug") and "MDd" or "MD")

target("rnnoise")
    set_default(true)
    set_kind("static")
    set_prefixname("")
    add_defines("_GNU_SOURCE")
    add_defines("_USE_MATH_DEFINES")
    add_defines("_CRT_SECURE_NO_WARNINGS")
    add_defines("RNNOISE_BUILD")
    add_files("src/*.c")
    add_headerfiles("src/*.h", "include/*.h")
    add_includedirs("src/", "include/", { public = true })
    after_build(function (target)
        for pkg, pkg_details in pairs(target:pkgs()) do
            if os.isdir(pkg_details._INFO.installdir) then
                os.cp(pkg_details._INFO.installdir .. "/**.so", target:targetdir())
                os.cp(pkg_details._INFO.installdir .. "/**.dll", target:targetdir())
                os.cp(pkg_details._INFO.installdir .. "/**.lib", target:targetdir())
                os.cp(pkg_details._INFO.installdir .. "/**.a", target:targetdir())
            end
        end
    end)

add_rules("plugin.vsxmake.autoupdate")