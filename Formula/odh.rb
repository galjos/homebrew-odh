class Odh < Formula
  desc "Agent-friendly CLI for public Open Data Hub APIs"
  homepage "https://github.com/galjos/odh-cli"
  url "https://github.com/galjos/odh-cli/archive/refs/tags/v0.2.5.tar.gz"
  sha256 "869d26e2e9863fbca82e59d8434fcb7839253152c5d6a0a4ecb7645b4363a2f5"
  license "MPL-2.0"
  head "https://github.com/galjos/odh-cli.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %w[
      -s -w
      -X github.com/galjos/odh-cli/internal/version.Version=0.2.5
      -X github.com/galjos/odh-cli/internal/version.Commit=4aed99bf689d
      -X github.com/galjos/odh-cli/internal/version.Date=2026-05-26T20:47:50Z
    ]

    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/odh"
    generate_completions_from_executable(bin/"odh", "completion")
  end

  test do
    assert_match "odh 0.2.5", shell_output("#{bin}/odh version --format text")
    assert_match "odh traffic today --area ueberetsch-unterland", shell_output("#{bin}/odh traffic today --help")
    assert_match "#compdef odh", shell_output("#{bin}/odh completion zsh")
    system bin/"odh", "doctor", "--network=false"
  end
end
