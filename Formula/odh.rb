class Odh < Formula
  desc "Agent-friendly CLI for public Open Data Hub APIs"
  homepage "https://github.com/galjos/odh-cli"
  url "https://github.com/galjos/odh-cli/archive/refs/tags/v0.4.2.tar.gz"
  sha256 "855a3aee17909f2985a0954300750130032a823205c8fe789a1f4c1ba5a9ffd6"
  license "MPL-2.0"
  head "https://github.com/galjos/odh-cli.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/galjos/odh-cli/internal/version.Version=#{version}
      -X github.com/galjos/odh-cli/internal/version.Commit=b7b7f9c2d4f5
      -X github.com/galjos/odh-cli/internal/version.Date=2026-08-03T10:54:29Z
    ]

    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/odh"
    generate_completions_from_executable(bin/"odh", "completion")
  end

  test do
    # Derived from the url, so a release that bumps one but not the other fails
    # here instead of shipping a binary that misreports its own version.
    assert_match "odh #{version}", shell_output("#{bin}/odh version --format text")
    assert_match "odh traffic today --area ueberetsch-unterland", shell_output("#{bin}/odh traffic today --help")
    assert_match "#compdef odh", shell_output("#{bin}/odh completion zsh")
    system bin/"odh", "doctor", "--network=false"
  end
end
