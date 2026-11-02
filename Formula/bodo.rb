# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1102.4690/bodo-darwin-arm64"
  version "2026.1102.4690"
  sha256 "2f24b4e039a513ebda6fd1ac1921f28da06868affcd6e5566ddf119a1c394b58"
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
      url "https://cli.bodo-app.com/v/2026.1102.4690/bodo-linux-arm64"
      sha256 "4a2175d65c270d6d9b780f652eeb9ea99ddb006e3d3e5f5dee98362190b3f929"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1102.4690/bodo-linux-x64"
      sha256 "a38fb9af5ee4487ef6b36b61aa99790f62819cf1d8f6effa805b284f7bb6a377"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
