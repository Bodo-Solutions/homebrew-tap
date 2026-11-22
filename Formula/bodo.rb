# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1122.4763/bodo-darwin-arm64"
  version "2026.1122.4763"
  sha256 "b7d12ebc703d90e76c7e1a94b3cc9296da8b35a4877c329fd6486b2b6d9ab0bd"
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
      url "https://cli.bodo-app.com/v/2026.1122.4763/bodo-linux-arm64"
      sha256 "57e6360c39370632c7296ac180a611b46c252c0dac23fdc1a32b77bc0570ac37"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1122.4763/bodo-linux-x64"
      sha256 "d5d296d70ad4b91eaee0f5335cf24012a50a5f636a53cf2032a24854be8474bd"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
