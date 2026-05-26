class Odh < Formula
  desc "Agent-friendly CLI for public Open Data Hub APIs"
  homepage "https://github.com/galjos/odh-cli"
  url "https://github.com/galjos/odh-cli/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "d9729079085344af42b0bd28ce7102d91a2c9da642275b5388853eceae5eefd4"
  license "MPL-2.0"
  head "https://github.com/galjos/odh-cli.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %w[
      -s -w
      -X github.com/galjos/odh-cli/internal/version.Version=0.2.3
      -X github.com/galjos/odh-cli/internal/version.Commit=982c88d12448
      -X github.com/galjos/odh-cli/internal/version.Date=2026-05-26T17:01:37Z
    ]

    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/odh"
    generate_completions_from_executable(bin/"odh", "completion")
  end

  test do
    assert_match "odh 0.2.3", shell_output("#{bin}/odh version --format text")
    assert_match "#compdef odh", shell_output("#{bin}/odh completion zsh")
    system bin/"odh", "doctor", "--network=false"
  end
end
