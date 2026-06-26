class Odh < Formula
  desc "Agent-friendly CLI for public Open Data Hub APIs"
  homepage "https://github.com/galjos/odh-cli"
  url "https://github.com/galjos/odh-cli/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "a6a3a171e66a8659ffb67723053a10ba8e84a976cd42e720263c7fc9c3bd1ce0"
  license "MPL-2.0"
  head "https://github.com/galjos/odh-cli.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %w[
      -s -w
      -X github.com/galjos/odh-cli/internal/version.Version=0.3.1
      -X github.com/galjos/odh-cli/internal/version.Commit=ce5ab3f470d3
      -X github.com/galjos/odh-cli/internal/version.Date=2026-06-26T11:38:26Z
    ]

    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/odh"
    generate_completions_from_executable(bin/"odh", "completion")
  end

  test do
    assert_match "odh 0.3.1", shell_output("#{bin}/odh version --format text")
    assert_match "odh traffic today --area ueberetsch-unterland", shell_output("#{bin}/odh traffic today --help")
    assert_match "#compdef odh", shell_output("#{bin}/odh completion zsh")
    system bin/"odh", "doctor", "--network=false"
  end
end
