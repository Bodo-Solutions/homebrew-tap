# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1102.4692/bodo-darwin-arm64"
  version "2026.1102.4692"
  sha256 "6c824b8e080f6052cf3c36aa93fac8f5d04ec567113b24fbb4c28d7c29efd4db"
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
      url "https://cli.bodo-app.com/v/2026.1102.4692/bodo-linux-arm64"
      sha256 "b7b2215821207a7a8f13c6c71fea1cd7e53eb14c08bb6fd201d2ac8a6ef7d280"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1102.4692/bodo-linux-x64"
      sha256 "e90e53f6abfc569dd0f8a9ef210d873e03db2ccc98c526a55f8257b81c061cdd"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
