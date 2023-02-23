class Zvm < Formula
  desc "Simple yet powerful version manager for Zig"
  homepage "https://github.com/gaetschwartz/zvm"
  url "https:/github.com/gaetschwartz/zvm/archive/0.2.10.tar.gz"
  sha256 "3d045aff1b1655cc26f891f75067d06a3c6ca48aad41874c5f5b16a0c49fdb7f"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      resource "zig" do
        url "https://ziglang.org/builds/zig-macos-aarch64-0.11.0-dev.1796+c9e02d3e6.tar.xz"
        sha256 "51b4e88123d6cbb102f2a6665dd0d61467341f36b07bb0a8d46a37ea367b60d5"
      end
    else
      resource "zig" do
        url "https://ziglang.org/builds/zig-macos-x86_64-0.11.0-dev.1796+c9e02d3e6.tar.xz"
        sha256 "dd8eeae5249aa21f9e51ff4ff536a3e7bf2c0686ee78bf6032d18e74c8416c56"
      end
    end
  end
  on_linux do
    if Hardware::CPU.arm?
      resource "zig" do
        url "https://ziglang.org/builds/zig-linux-aarch64-0.11.0-dev.1796+c9e02d3e6.tar.xz"
        sha256 "5902b34b463635b25c11555650d095eb5030e2a05d8a4570c091313cd1a38b12"
      end
    else
      resource "zig" do
        url "https://ziglang.org/builds/zig-linux-x86_64-0.11.0-dev.1796+c9e02d3e6.tar.xz"
        sha256 "aa9da2305fad89f648db2fd1fade9f0f9daf01d06f3b07887ad3098402794778"
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
    generate_completions_from_executable(bin/"zvm", "completions", "--shell", "zsh", shells: [:zsh])
  end

  test do
    system "#{bin}/zvm", "--version", "--verbose"
  end
end
