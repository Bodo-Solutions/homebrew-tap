# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1117.4747/bodo-darwin-arm64"
  version "2026.1117.4747"
  sha256 "e7a765b415dbcdc06c53f324d563a5f186d686a3468c43e8c11600a0e129b5ef"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/stable/manifest.json"
    regex(/^v?(\d+(?:\.\d+)+(?:-rc)?)$/i)
    strategy :json do |json, regex|
      json["version"]&.[](regex, 1)
    end
  end

  on_macos do
    depends_on arch: :arm64 unless Hardware::CPU.in_rosetta2?
  end

  on_linux do
    on_arm do
      url "https://cli.bodo-app.com/v/2026.1117.4747/bodo-linux-arm64"
      sha256 "48c02774cb2f3b6251e71aaab55ee6e6cd4b7b4894ac20e52f46ade917ed6d01"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1117.4747/bodo-linux-x64"
      sha256 "49b685f3d3dbddb254a6537abe92cf49229a42a6b86874ea4941990c94bb9cf7"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
