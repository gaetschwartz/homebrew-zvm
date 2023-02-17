class Zvm < Formula
  desc "Simple yet powerful version manager for Zig"
  homepage "https://github.com/gaetschwartz/zvm"
  url "https:/github.com/gaetschwartz/zvm/archive/0.2.5.tar.gz"
  sha256 "2af0e7db0b8a9a8cefd1767fbc2a053c9e96821a082afb8b8371bee06752f33e"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      resource "zig" do
        url "https://ziglang.org/builds/zig-macos-aarch64-0.11.0-dev.1638+7199d7c77.tar.xz"
        sha256 "5709c27d581988f50f5e6fd5b69d92707787e803a1d04992e290b764617664e6"
      end
    else
      resource "zig" do
        url "https://ziglang.org/builds/zig-macos-x86_64-0.11.0-dev.1638+7199d7c77.tar.xz"
        sha256 "88d194adb2f3c1a9edbb4a24d018007d5f827a57d1d26b2d9f3459236da1b7b6"
      end
    end
  end
  on_linux do
    if Hardware::CPU.arm?
      resource "zig" do
        url "https://ziglang.org/builds/zig-linux-aarch64-0.11.0-dev.1638+7199d7c77.tar.xz"
        sha256 "b759a11993949531c692ccfc3d1a004b14df714a7a3515fe0b5c90c9a7631d61"
      end
    else
      resource "zig" do
        url "https://ziglang.org/builds/zig-linux-x86_64-0.11.0-dev.1638+7199d7c77.tar.xz"
        sha256 "028dad5189e02b2058679b64df16e854a1c1ca0e6044b334d4f3be6e35544f07"
      end
    end
  end

  resource "known-folders" do
    url "https://github.com/ziglibs/known-folders/archive/53fe3b676f32e59d46f4fd201d7ab200e5f6cb98.tar.gz"
    sha256 "3c9d1e293df9e3e48b96114859267c2bf5d8cc924e7e5f7a9628d0c77bb43709"
  end

  def install
    resource("zig").unpack "ziglang-org/zig"
    resource("known-folders").unpack "known-folders"
    system "ziglang-org/zig/zig", "build", "-Doptimize=ReleaseSafe"
    bin.install "zig-out/bin/zvm"
    generate_completions_from_executable(bin/"zvm", "completions", shell_parameter_format: "--shell=", shells: ["zsh"])
  end

  test do
    system "#{bin}/zvm", "--version", "--verbose"
  end
end
