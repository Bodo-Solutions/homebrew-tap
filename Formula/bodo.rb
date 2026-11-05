# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1105.4702/bodo-darwin-arm64"
  version "2026.1105.4702"
  sha256 "14078722ad033807059ba7261cb849cf3b39dcdd42c3ec6aad10680438f32d06"
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
      url "https://cli.bodo-app.com/v/2026.1105.4702/bodo-linux-arm64"
      sha256 "d2a2f78b95668e76bbf89448b28c7f6c8f4d1b6a37c0d6005ee7f4ccad7ea6dc"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1105.4702/bodo-linux-x64"
      sha256 "9ceef664a83aa6887b4a1e793d70de3a0b173ef296fb9d23c0f6e85798604950"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
