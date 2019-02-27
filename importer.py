import itertools
import os
import xml.etree.ElementTree as ET


def strip_starting_dotslash(value: str):
    if not value.startswith("./"):
        return value

    return value[2:]


def strip_extension(value: str):
    split = value.rsplit(".", 1)
    if not len(split) == 2:
        return value

    return split[0]


def find_image(basepath: str, subfolder: str, filename: str):
    expected = os.path.join(basepath, "media", subfolder, filename)
    if os.path.exists(expected + ".png"):
        return expected + ".png"
    if os.path.exists(expected + ".jpg"):
        return expected + ".jpg"
    return None


def read_xml(path: str):
    tree = ET.parse(path)
    root = tree.getroot()
    games = list()
    basepath = path.rsplit("\\", 1)[0]
    for game in root.findall("game"):
        game_data = dict()
        game_data["file"] = strip_starting_dotslash(game.find("path").text)
        game_data["developer"] = game.find("developer").text
        game_data["title"] = game.find("name").text
        game_data["assets"] = dict()
        game_data["assets"]["tile"] = find_image(
            basepath, "tile", strip_extension(game_data["file"])
        )
        game_data["assets"]["screenshot"] = list()
        game_data["assets"]["screenshot"].append(
            find_image(basepath, "screenshot", strip_extension(game_data["file"]))
        )
        game_data["assets"]["screenshot"].append(
            find_image(basepath, "fanart", strip_extension(game_data["file"]))
        )
        game_data["assets"]["screenshot"].append(
            find_image(basepath, "screenshottitle", strip_extension(game_data["file"]))
        )
        game_data["assets"]["screenshot"] = [
            x for x in game_data["assets"]["screenshot"] if x is not None
        ]
        game_data["assets"]["logo"] = find_image(
            basepath, "wheel", strip_extension(game_data["file"])
        )
        games.append(game_data)
    return games


def output_dict(info: dict, path=""):
    res_string = ""
    for (key, value) in info.items():
        if isinstance(value, dict):
            res_string = res_string + output_dict(value, key + ".")
        elif isinstance(value, list):
            for item in value:
                if item is not None:
                    res_string = res_string + path + key + ": " + item + "\n"
        elif value is not None:
            res_string = res_string + path + key + ": " + value + "\n"

    return res_string


def process_file(path: str, output: str):
    game_data = read_xml(path)
    metadata = ""
    for game in game_data:
        metadata = metadata + "\n\n" + output_dict(game)

    with open(os.path.join(output, "metadata.txt"), mode="w") as f:
        f.writelines(metadata)


if __name__ == "__main__":
    xml_path = input("Folder containing the roms: ")

    process_file(xml_path, xml_path.rsplit("\\", 1)[0])
