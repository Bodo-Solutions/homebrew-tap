# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1026.4443-rc/bodo-darwin-arm64"
  version "2026.1026.4443-rc"
  sha256 "4c7c28c81f4847cb0ba992e0e628817ad9e97e57af0f6b7bc194455d24cba488"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/rc/manifest.json"
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
      url "https://cli.bodo-app.com/v/2026.1026.4443-rc/bodo-linux-arm64"
      sha256 "5f6fd6b74982466a3b01332cf14cf642659f35323005a1ba0a5e1a06d0a9c7fe"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1026.4443-rc/bodo-linux-x64"
      sha256 "85df1618f316ceb1e889c65fd6d8d076771af2eab1fee8b3f93f5ab3695f83a0"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
