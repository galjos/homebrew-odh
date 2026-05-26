class Odh < Formula
  desc "Agent-friendly CLI for public Open Data Hub APIs"
  homepage "https://github.com/galjos/odh-cli"
  url "https://github.com/galjos/odh-cli/archive/refs/tags/v0.2.4.tar.gz"
  sha256 "ccf77b3390a642c2b9ddcc99b13db29a8514e09076e920acbaa1fa9eaf0c4716"
  license "MPL-2.0"
  head "https://github.com/galjos/odh-cli.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %w[
      -s -w
      -X github.com/galjos/odh-cli/internal/version.Version=0.2.4
      -X github.com/galjos/odh-cli/internal/version.Commit=a4e0a7f8d336
      -X github.com/galjos/odh-cli/internal/version.Date=2026-05-26T20:04:32Z
    ]

    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/odh"
    generate_completions_from_executable(bin/"odh", "completion")
  end

  test do
    assert_match "odh 0.2.4", shell_output("#{bin}/odh version --format text")
    assert_match "#compdef odh", shell_output("#{bin}/odh completion zsh")
    system bin/"odh", "doctor", "--network=false"
  end
end
